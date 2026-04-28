import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../store/work_store.dart';
import '../theme/app_theme.dart';
import '../widgets/arc_progress_ring.dart';
import '../models/work_session.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late Timer _ticker;
  DateTime _now = DateTime.now();

  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now());
    });

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.07).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _ticker.cancel();
    _pulseCtrl.dispose();
    super.dispose();
  }

  void _startPulse() {
    _pulseCtrl.repeat(reverse: true);
  }

  void _stopPulse() {
    _pulseCtrl.stop();
    _pulseCtrl.reset();
  }

  String _formatTime(DateTime dt) => DateFormat('HH:mm').format(dt);

  String _elapsedFormatted(DateTime start) {
    final d = _now.difference(start);
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    return '${h.toString().padLeft(2, '0')}h${m.toString().padLeft(2, '0')}';
  }

  double _ringProgress(WorkStore store) {
    final active = store.activeSession;
    if (active == null) return 0;
    final dailySecs = (store.weeklyTargetHours / 5.0) * 3600;
    if (dailySecs == 0) return 0;
    return (_now.difference(active.arrivalTime).inSeconds / dailySecs)
        .clamp(0.0, 1.0);
  }

  void _handleClockIn(WorkStore store) {
    store.clockIn();
    _startPulse();
  }

  void _confirmClockOut(BuildContext context, WorkStore store) {
    showModalBottomSheet(
      context: context,
      backgroundColor: WTColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _ClockOutSheet(
        onConfirm: () {
          store.clockOut();
          _stopPulse();
          Navigator.pop(context);
        },
        onCancel: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<WorkStore>();
    final isActive = store.isClockedIn;
    final active = store.activeSession;

    // Sync pulse with active state
    if (isActive && !_pulseCtrl.isAnimating) _startPulse();
    if (!isActive && _pulseCtrl.isAnimating) _stopPulse();

    return Scaffold(
      backgroundColor: WTColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ── Top bar ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 16, 28, 0),
              child: Row(
                children: [
                  Text(
                    DateFormat('EEEE d MMMM', 'fr_FR')
                        .format(_now)
                        .toUpperCase(),
                    style: WTText.caps(11),
                  ),
                  const Spacer(),
                  _WeekBadge(store: store),
                ],
              ),
            ),

            const Spacer(),

            // ── Central ring ───────────────────────────────────────────
            AnimatedBuilder(
              animation: _pulseAnim,
              builder: (_, child) => Transform.scale(
                scale: isActive ? _pulseAnim.value : 1.0,
                child: child,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer glow when active
                  if (isActive)
                    ArcProgressRing(
                      progress: 1,
                      size: 296,
                      strokeWidth: 2,
                      foreground: WTColors.accent.withOpacity(0.2),
                      background: Colors.transparent,
                    ),
                  ArcProgressRing(
                    progress: _ringProgress(store),
                    size: 260,
                    strokeWidth: 7,
                    foreground: WTColors.accent,
                    background: WTColors.border,
                  ),
                  // Inner text
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isActive && active != null) ...[
                        Text(
                          'EN COURS',
                          style: WTText.caps(10)
                              .copyWith(color: WTColors.accent, letterSpacing: 3),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _elapsedFormatted(active.arrivalTime),
                          style: WTText.mono(52),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'depuis ${_formatTime(active.arrivalTime)}',
                          style: WTText.body(14)
                              .copyWith(color: WTColors.secondary),
                        ),
                      ] else ...[
                        Text(
                          _formatTime(_now),
                          style: WTText.mono(58),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Prêt à pointer',
                          style: WTText.body(14)
                              .copyWith(color: WTColors.secondary),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ── Action button ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onTap: isActive
                    ? () => _confirmClockOut(context, store)
                    : () => _handleClockIn(store),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                    color: isActive ? WTColors.surface : WTColors.primary,
                    borderRadius: BorderRadius.circular(20),
                    border: isActive
                        ? Border.all(color: WTColors.border)
                        : null,
                    boxShadow: isActive
                        ? null
                        : [
                            BoxShadow(
                              color: WTColors.primary.withOpacity(0.14),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                  ),
                  child: Row(
                    children: [
                      // Status dot
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive ? WTColors.red : WTColors.accent,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        isActive
                            ? 'Pointer ma sortie'
                            : "Pointer mon arrivée",
                        style: WTText.label(17).copyWith(
                          color: isActive
                              ? WTColors.primary
                              : WTColors.surface,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        isActive
                            ? Icons.stop_circle_outlined
                            : Icons.arrow_forward,
                        color: isActive ? WTColors.red : WTColors.accent,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ── Bottom info bar ────────────────────────────────────────
            _DepartureBar(store: store, now: _now),
          ],
        ),
      ),
    );
  }
}

// ── Week Badge ────────────────────────────────────────────────────────────

class _WeekBadge extends StatelessWidget {
  final WorkStore store;
  const _WeekBadge({required this.store});

  @override
  Widget build(BuildContext context) {
    final pct = (store.currentWeekProgress * 100).round();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: WTColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: WTColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ArcProgressRing(
            progress: store.currentWeekProgress,
            size: 20,
            strokeWidth: 3,
            foreground: WTColors.accent,
            background: WTColors.border,
          ),
          const SizedBox(width: 6),
          Text('$pct%', style: WTText.label(13)),
        ],
      ),
    );
  }
}

// ── Departure Bar ─────────────────────────────────────────────────────────

class _DepartureBar extends StatelessWidget {
  final WorkStore store;
  final DateTime now;

  const _DepartureBar({required this.store, required this.now});

  String _weeklyFormatted() {
    final d = store.currentWeekTotal;
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    return '${h}h${m.toString().padLeft(2, '0')}';
  }

  String _departureTime() {
    final active = store.activeSession;
    if (active == null) return '--:--';
    final dep = store.expectedDeparture(active);
    if (dep == null) return '--:--';
    return DateFormat('HH:mm').format(dep);
  }

  @override
  Widget build(BuildContext context) {
    final isActive = store.isClockedIn;
    return Container(
      decoration: const BoxDecoration(
        color: WTColors.surface,
        border: Border(top: BorderSide(color: WTColors.border)),
      ),
      padding: const EdgeInsets.fromLTRB(28, 16, 28, 0),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Departure
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DÉPART PRÉVU', style: WTText.caps(10)),
                const SizedBox(height: 4),
                Text(
                  isActive ? _departureTime() : '--:--',
                  style: WTText.mono(26).copyWith(
                    color: isActive
                        ? WTColors.primary
                        : WTColors.secondary.withOpacity(0.35),
                  ),
                ),
              ],
            ),
            // Separator
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              width: 1,
              height: 44,
              color: WTColors.border,
            ),
            // Weekly
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('SEMAINE', style: WTText.caps(10)),
                const SizedBox(height: 4),
                Text(
                  _weeklyFormatted(),
                  style: WTText.mono(26),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Clock Out Sheet ───────────────────────────────────────────────────────

class _ClockOutSheet extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const _ClockOutSheet({
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pointer la sortie', style: WTText.heading(22)),
            const SizedBox(height: 8),
            Text(
              'Êtes-vous sûr de vouloir enregistrer votre heure de sortie ?',
              style:
                  WTText.body(15).copyWith(color: WTColors.secondary),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onCancel,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: WTColors.background,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: WTColors.border),
                      ),
                      child: Center(
                        child: Text('Annuler', style: WTText.label(15)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: onConfirm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: WTColors.primary,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          'Confirmer',
                          style: WTText.label(15)
                              .copyWith(color: WTColors.surface),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
