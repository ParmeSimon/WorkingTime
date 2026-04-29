import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../store/work_store.dart';
import '../theme/app_theme.dart';
import '../widgets/arc_progress_ring.dart';
import '../models/work_session.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';

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

  void _startPulse() => _pulseCtrl.repeat(reverse: true);

  void _stopPulse() {
    _pulseCtrl.stop();
    _pulseCtrl.reset();
  }

  String _formatTime(DateTime dt) => DateFormat('HH:mm').format(dt);

  /// Net work time = elapsed since arrival minus all pause durations.
  String _netElapsedFormatted(WorkSession active) {
    final elapsed = _now.difference(active.arrivalTime);
    final net = elapsed - active.totalPauseDurationAt(_now);
    final h = net.inHours;
    final m = net.inMinutes.remainder(60);
    return '${h.toString().padLeft(2, '0')}h${m.toString().padLeft(2, '0')}';
  }

  /// Current pause duration.
  String _pauseDurationFormatted(WorkPause pause) {
    final d = _now.difference(pause.start);
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    if (h > 0) return '${h}h${m.toString().padLeft(2, '0')}';
    return '$m min';
  }

  double _ringProgress(WorkStore store) {
    if (store.isDailyMode) {
      // Daily mode: active session net time vs today's daily target
      final active = store.activeSession;
      if (active == null) return 0;
      final dailySecs = store.dailyTargetForDay(active.arrivalTime) * 3600;
      if (dailySecs == 0) return 0;
      final elapsed = _now.difference(active.arrivalTime);
      final net = elapsed - active.totalPauseDurationAt(_now);
      return (net.inSeconds / dailySecs).clamp(0.0, 1.0);
    } else {
      // Weekly mode: cumulative week progress (live)
      return store.currentWeekProgress;
    }
  }

  /// Label and value shown inside the ring in weekly mode.
  String _weeklyElapsedFormatted(WorkStore store) {
    final d = store.currentWeekTotal;
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    return '${h.toString().padLeft(2, '0')}h${m.toString().padLeft(2, '0')}';
  }

  String _fmtHours(double h) {
    final totalMin = (h * 60).round();
    final hours = totalMin ~/ 60;
    final minutes = totalMin % 60;
    if (minutes == 0) return '${hours}h';
    return '${hours}h${minutes.toString().padLeft(2, '0')}';
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
    final isPaused = store.isPaused;
    final active = store.activeSession;

    // Sync pulse: runs only when working, not when paused
    if (isActive && !isPaused && !_pulseCtrl.isAnimating) _startPulse();
    if ((!isActive || isPaused) && _pulseCtrl.isAnimating) _stopPulse();

    final ringColor = isPaused ? WTColors.orange : WTColors.accent;

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
                scale: (isActive && !isPaused) ? _pulseAnim.value : 1.0,
                child: child,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer glow when working (not paused)
                  if (isActive && !isPaused)
                    ArcProgressRing(
                      progress: 1,
                      size: 296,
                      strokeWidth: 2,
                      foreground: ringColor.withOpacity(0.2),
                      background: Colors.transparent,
                    ),
                  ArcProgressRing(
                    progress: _ringProgress(store),
                    size: 260,
                    strokeWidth: 7,
                    foreground: ringColor,
                    background: WTColors.border,
                  ),
                  // Inner text
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isActive && active != null) ...[
                        // State label
                        Text(
                          isPaused
                                ? AppLocalizations.of(context)!.homeStatusPaused
                                : (store.isDailyMode
                                    ? AppLocalizations.of(context)!.homeStatusActive
                                    : AppLocalizations.of(context)!.homeStatusWeekly),
                          style: WTText.caps(10).copyWith(
                            color: ringColor,
                            letterSpacing: 3,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Time value — daily = session net, weekly = week total
                        Text(
                          store.isDailyMode || isPaused
                              ? _netElapsedFormatted(active)
                              : _weeklyElapsedFormatted(store),
                          style: WTText.mono(52),
                        ),
                        const SizedBox(height: 4),
                        // Context line
                        if (isPaused && active.currentPause != null)
                          Text(
                            AppLocalizations.of(context)!.homePauseContext(
                              _pauseDurationFormatted(active.currentPause!),
                              _formatTime(active.arrivalTime),
                            ),
                            style: WTText.body(13)
                                .copyWith(color: WTColors.secondary),
                          )
                        else if (store.isDailyMode)
                          Text(
                            AppLocalizations.of(context)!.homeArrivalSince(
                              _formatTime(active.arrivalTime),
                            ),
                            style: WTText.body(14)
                                .copyWith(color: WTColors.secondary),
                          )
                        else
                          Text(
                            AppLocalizations.of(context)!.homeObjective(
                              _fmtHours(store.effectiveWeeklyTarget),
                            ),
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
                          AppLocalizations.of(context)!.homeReadyToClockIn,
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

            // ── Objective mode toggle ──────────────────────────────────
            _ObjectiveModeToggle(store: store),

            const SizedBox(height: 20),

            // ── Action buttons ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: isActive
                  ? _ActiveButtons(
                      isPaused: isPaused,
                      onPause: () => store.startPause(),
                      onResume: () => store.endPause(),
                      onClockOut: () => _confirmClockOut(context, store),
                    )
                  : _ClockInButton(
                      onTap: () => _handleClockIn(store),
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

// ── Objective Mode Toggle (home screen pill) ──────────────────────────────

class _ObjectiveModeToggle extends StatelessWidget {
  final WorkStore store;
  const _ObjectiveModeToggle({required this.store});

  @override
  Widget build(BuildContext context) {
    final isDaily = store.isDailyMode;
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: WTColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: WTColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _pill(context, AppLocalizations.of(context)!.homeModeDaily, isDaily,
              () => store.setObjectiveMode(isDailyMode: true)),
          _pill(context, AppLocalizations.of(context)!.homeModeWeekly, !isDaily,
              () => store.setObjectiveMode(isDailyMode: false)),
        ],
      ),
    );
  }

  Widget _pill(BuildContext context, String label, bool selected,
      VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? WTColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Text(
          label,
          style: WTText.label(13).copyWith(
            color: selected ? WTColors.surface : WTColors.secondary,
          ),
        ),
      ),
    );
  }
}

// ── Active Buttons (pause/resume + clock-out) ─────────────────────────────

class _ActiveButtons extends StatelessWidget {
  final bool isPaused;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onClockOut;

  const _ActiveButtons({
    required this.isPaused,
    required this.onPause,
    required this.onResume,
    required this.onClockOut,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Primary: pause or resume
        GestureDetector(
          onTap: isPaused ? onResume : onPause,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: isPaused ? WTColors.primary : WTColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: isPaused
                  ? null
                  : Border.all(color: WTColors.border),
              boxShadow: isPaused
                  ? [
                      BoxShadow(
                        color: WTColors.primary.withOpacity(0.14),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isPaused ? WTColors.accent : WTColors.orange,
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  isPaused ? AppLocalizations.of(context)!.homeResume : AppLocalizations.of(context)!.homePause,
                  style: WTText.label(17).copyWith(
                    color:
                        isPaused ? WTColors.surface : WTColors.primary,
                  ),
                ),
                const Spacer(),
                Icon(
                  isPaused
                      ? Icons.arrow_forward
                      : Icons.pause_circle_outline,
                  color: isPaused ? WTColors.accent : WTColors.orange,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Secondary: clock out
        GestureDetector(
          onTap: onClockOut,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
              color: WTColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: WTColors.border),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: WTColors.red,
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  AppLocalizations.of(context)!.homeClockOut,
                  style:
                      WTText.label(15).copyWith(color: WTColors.primary),
                ),
                const Spacer(),
                const Icon(Icons.stop_circle_outlined,
                    color: WTColors.red, size: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Clock-in Button ───────────────────────────────────────────────────────

class _ClockInButton extends StatelessWidget {
  final VoidCallback onTap;
  const _ClockInButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: WTColors.primary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: WTColors.primary.withOpacity(0.14),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: WTColors.accent,
              ),
            ),
            const SizedBox(width: 14),
            Text(
              AppLocalizations.of(context)!.homeClockIn,
              style:
                  WTText.label(17).copyWith(color: WTColors.surface),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward,
                color: WTColors.accent, size: 22),
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
                Text(AppLocalizations.of(context)!.homeExpectedDeparture, style: WTText.caps(10)),
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
                Text(AppLocalizations.of(context)!.homeWeekLabel, style: WTText.caps(10)),
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
            Text(AppLocalizations.of(context)!.homeClockOutTitle, style: WTText.heading(22)),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.homeClockOutConfirm,
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
                        child: Text(AppLocalizations.of(context)!.cancel, style: WTText.label(15)),
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
                          AppLocalizations.of(context)!.confirm,
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
