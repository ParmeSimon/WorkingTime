import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../store/work_store.dart';
import '../theme/app_theme.dart';
import '../widgets/arc_progress_ring.dart';
import '../widgets/tag_pill.dart';
import '../models/work_session.dart';

class WeeklyScreen extends StatefulWidget {
  const WeeklyScreen({super.key});

  @override
  State<WeeklyScreen> createState() => _WeeklyScreenState();
}

class _WeeklyScreenState extends State<WeeklyScreen> {
  late Timer _ticker;

  @override
  void initState() {
    super.initState();
    // Refresh every 30 s to update live session contribution
    _ticker = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker.cancel();
    super.dispose();
  }

  String _weekRange() {
    final now = DateTime.now();
    final daysFromMonday = (now.weekday - 1) % 7;
    final monday = now.subtract(Duration(days: daysFromMonday));
    final sunday = monday.add(const Duration(days: 6));
    final f = DateFormat('d MMM', 'fr_FR');
    return '${f.format(monday)} – ${f.format(sunday)}';
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<WorkStore>();
    final worked = store.currentWeekTotal;
    final target = Duration(seconds: (store.weeklyTargetHours * 3600).round());
    final remaining = worked < target ? target - worked : Duration.zero;
    final overtime = worked > target ? worked - target : Duration.zero;
    final progress = store.currentWeekProgress;
    final isOver = worked > target;

    return Scaffold(
      backgroundColor: WTColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Title ──────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 28, 28, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CETTE\nSEMAINE', style: WTText.display(42)),
                    const SizedBox(height: 6),
                    Text(
                      _weekRange().toUpperCase(),
                      style: WTText.caps(11),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ── Ring + Stats ───────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Ring
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ArcProgressRing(
                          progress: progress,
                          size: 150,
                          strokeWidth: 14,
                          foreground:
                              isOver ? WTColors.accent : WTColors.primary,
                          background: WTColors.border,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${(progress * 100).round()}%',
                              style: WTText.display(28),
                            ),
                            Text(
                              'objectif',
                              style: WTText.body(11)
                                  .copyWith(color: WTColors.secondary),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(width: 32),

                    // Stats column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _StatRow(
                              label: 'Travaillé',
                              value: _fmt(worked)),
                          _Divider(),
                          _StatRow(
                              label: 'Objectif',
                              value: _fmt(target)),
                          _Divider(),
                          if (isOver)
                            _StatRow(
                              label: 'Heures sup.',
                              value: _fmt(overtime),
                              accent: true,
                            )
                          else
                            _StatRow(
                              label: 'Restant',
                              value: _fmt(remaining),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // ── Daily breakdown ────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 0, 28, 12),
                child: Text('Journées', style: WTText.caps(11)),
              ),

              ..._buildDayRows(store),

              // ── Target editor ──────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                child: _TargetEditor(store: store),
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDayRows(WorkStore store) {
    final now = DateTime.now();
    final daysFromMonday = (now.weekday - 1) % 7;
    final monday = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: daysFromMonday));

    final days = List.generate(
      daysFromMonday + 1,
      (i) => monday.add(Duration(days: i)),
    ).reversed.toList();

    return days.map((day) {
      final sessions = store.sessions
          .where((s) =>
              !s.isActive &&
              s.arrivalTime.year == day.year &&
              s.arrivalTime.month == day.month &&
              s.arrivalTime.day == day.day)
          .toList();

      final total = sessions
          .map((s) => s.duration ?? Duration.zero)
          .fold(Duration.zero, (a, b) => a + b);

      final dailyTarget = store.weeklyTargetHours / 5.0;
      final dayProgress = dailyTarget > 0
          ? (total.inSeconds / (dailyTarget * 3600)).clamp(0.0, 1.0)
          : 0.0;

      final isToday = day.year == now.year &&
          day.month == now.month &&
          day.day == now.day;

      return _DayRow(
        day: day,
        total: total,
        progress: dayProgress,
        isToday: isToday,
        hasData: sessions.isNotEmpty,
      );
    }).toList();
  }

  String _fmt(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    return '${h}h${m.toString().padLeft(2, '0')}';
  }
}

// ── Stat Row ──────────────────────────────────────────────────────────────

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final bool accent;

  const _StatRow({
    required this.label,
    required this.value,
    this.accent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: WTText.body(12).copyWith(color: WTColors.secondary)),
          const SizedBox(height: 2),
          Container(
            color: accent ? WTColors.accent.withOpacity(0.3) : Colors.transparent,
            child: Text(value, style: WTText.mono(22)),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(height: 1, color: WTColors.border);
}

// ── Day Row ───────────────────────────────────────────────────────────────

class _DayRow extends StatelessWidget {
  final DateTime day;
  final Duration total;
  final double progress;
  final bool isToday;
  final bool hasData;

  const _DayRow({
    required this.day,
    required this.total,
    required this.progress,
    required this.isToday,
    required this.hasData,
  });

  @override
  Widget build(BuildContext context) {
    final dayName = DateFormat('EEE', 'fr_FR').format(day);
    final h = total.inHours;
    final m = total.inMinutes.remainder(60);
    final label = hasData ? '${h}h${m.toString().padLeft(2, '0')}' : '—';

    return Container(
      color: isToday ? WTColors.surface : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 88,
                child: Row(
                  children: [
                    Text(
                      dayName[0].toUpperCase() + dayName.substring(1),
                      style: WTText.label(isToday ? 15 : 14).copyWith(
                        color: isToday ? WTColors.primary : WTColors.secondary,
                      ),
                    ),
                    if (isToday) ...[
                      const SizedBox(width: 8),
                      const TagPill(text: "Auj.", color: WTColors.accent),
                    ],
                  ],
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Stack(
                    children: [
                      Container(height: 6, color: WTColors.border),
                      FractionallySizedBox(
                        widthFactor: progress,
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: progress >= 1
                                ? WTColors.accent
                                : WTColors.primary,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  label,
                  textAlign: TextAlign.end,
                  style: WTText.mono(14).copyWith(
                    color: hasData
                        ? WTColors.primary
                        : WTColors.secondary.withOpacity(0.4),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 14),
            height: 1,
            color: WTColors.border,
          ),
        ],
      ),
    );
  }
}

// ── Target Editor ─────────────────────────────────────────────────────────

class _TargetEditor extends StatefulWidget {
  final WorkStore store;
  const _TargetEditor({required this.store});

  @override
  State<_TargetEditor> createState() => _TargetEditorState();
}

class _TargetEditorState extends State<_TargetEditor> {
  bool _expanded = false;
  late double _local;

  @override
  void initState() {
    super.initState();
    _local = widget.store.weeklyTargetHours;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() {
              _expanded = !_expanded;
              if (_expanded) _local = widget.store.weeklyTargetHours;
            }),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: WTColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: WTColors.border),
              ),
              child: Row(
                children: [
                  Text(
                    'Modifier l\'objectif hebdomadaire',
                    style: WTText.label(14),
                  ),
                  const Spacer(),
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    color: WTColors.secondary,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          if (_expanded) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: WTColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: WTColors.border),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Objectif actuel',
                          style: WTText.body(14)
                              .copyWith(color: WTColors.secondary)),
                      const Spacer(),
                      Text(
                        _local % 1 == 0
                            ? '${_local.toInt()}h'
                            : '${_local}h',
                        style: WTText.mono(20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: WTColors.primary,
                      inactiveTrackColor: WTColors.border,
                      thumbColor: WTColors.primary,
                      overlayColor: WTColors.primary.withOpacity(0.08),
                      trackHeight: 3,
                    ),
                    child: Slider(
                      value: _local,
                      min: 20,
                      max: 50,
                      divisions: 60,
                      onChanged: (v) => setState(() => _local = v),
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      widget.store.setWeeklyTarget(_local);
                      setState(() => _expanded = false);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: WTColors.accent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text('Enregistrer', style: WTText.label(15)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
