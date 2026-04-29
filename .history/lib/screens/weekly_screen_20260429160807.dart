import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../store/work_store.dart';
import '../theme/app_theme.dart';
import '../widgets/arc_progress_ring.dart';
import '../widgets/tag_pill.dart';
import '../l10n/app_localizations.dart';
import 'legal_screen.dart';

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

  String _weekRange(BuildContext context) {
    final now = DateTime.now();
    final daysFromMonday = (now.weekday - 1) % 7;
    final monday = now.subtract(Duration(days: daysFromMonday));
    final sunday = monday.add(const Duration(days: 6));
    final locale = Localizations.localeOf(context).toLanguageTag();
    final f = DateFormat('d MMM', locale);
    return '${f.format(monday)} - ${f.format(sunday)}';
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
                      _weekRange(context).toUpperCase(),
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
                              AppLocalizations.of(context)!.weeklyObjectiveLabel,
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
                              label: AppLocalizations.of(context)!.weeklyWorked,
                              value: _fmt(worked)),
                          _Divider(),
                          _StatRow(
                              label: AppLocalizations.of(context)!.weeklyObjective,
                              value: _fmt(target)),
                          _Divider(),
                          if (isOver)
                            _StatRow(
                              label: AppLocalizations.of(context)!.weeklyOvertime,
                              value: _fmt(overtime),
                              accent: true,
                            )
                          else
                            _StatRow(
                              label: AppLocalizations.of(context)!.weeklyRemaining,
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
                child: Text(AppLocalizations.of(context)!.weeklyDays, style: WTText.caps(11)),
              ),

              ..._buildDayRows(store),

              // ── Settings ────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                child: Text(AppLocalizations.of(context)!.weeklySettings, style: WTText.caps(11)),
              ),

              // Objective mode
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                child: _ObjectiveModePicker(store: store),
              ),

              // Daily schedule — visible only in "Journalier" mode
              if (store.isDailyMode)
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                  child: _DailyScheduleEditor(store: store),
                ),

              // Weekly target — visible only in "Hebdomadaire" mode
              if (!store.isDailyMode)
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                  child: _TargetEditor(store: store),
                ),

              // Lunch break
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                child: _LunchBreakPicker(store: store),
              ),

              // Legal link
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Center(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const LegalScreen()),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.legalLinkText,
                      style: WTText.body(12).copyWith(
                        color: WTColors.secondary,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
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

      final dailyTarget = store.dailyTargetForDay(day);
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
    final locale = Localizations.localeOf(context).toLanguageTag();
    final dayName = DateFormat('EEE', locale).format(day);
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
                      TagPill(text: AppLocalizations.of(context)!.weeklyToday, color: WTColors.accent),
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

// ── Objective Mode Picker ─────────────────────────────────────────────────

class _ObjectiveModePicker extends StatelessWidget {
  final WorkStore store;
  const _ObjectiveModePicker({required this.store});

  @override
  Widget build(BuildContext context) {
    final isDaily = store.isDailyMode;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: WTColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: WTColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.weeklyObjectiveMode, style: WTText.label(14)),
                const SizedBox(height: 2),
                Text(
                  isDaily
                      ? AppLocalizations.of(context)!.weeklyDailyProgressDesc
                      : AppLocalizations.of(context)!.weeklyWeekProgressDesc,
                  style:
                      WTText.body(12).copyWith(color: WTColors.secondary),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _ModeToggle(
            isDaily: isDaily,
            onChanged: (v) =>
                store.setObjectiveMode(isDailyMode: v),
          ),
        ],
      ),
    );
  }
}

class _ModeToggle extends StatelessWidget {
  final bool isDaily;
  final ValueChanged<bool> onChanged;
  const _ModeToggle({required this.isDaily, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: WTColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: WTColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _pill(context, AppLocalizations.of(context)!.weeklyModeDay, isDaily, () => onChanged(true)),
          _pill(context, AppLocalizations.of(context)!.weeklyModeWeek, !isDaily, () => onChanged(false)),
        ],
      ),
    );
  }

  Widget _pill(BuildContext context, String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? WTColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
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

// ── Daily Schedule Editor ─────────────────────────────────────────────────

class _DailyScheduleEditor extends StatefulWidget {
  final WorkStore store;
  const _DailyScheduleEditor({required this.store});

  @override
  State<_DailyScheduleEditor> createState() => _DailyScheduleEditorState();
}

class _DailyScheduleEditorState extends State<_DailyScheduleEditor> {
  bool _expanded = false;
  late Map<int, double> _local;

  String _dayName(BuildContext context, int day) {
    final l = AppLocalizations.of(context)!;
    switch (day) {
      case 1: return l.dayMon;
      case 2: return l.dayTue;
      case 3: return l.dayWed;
      case 4: return l.dayThu;
      case 5: return l.dayFri;
      case 6: return l.daySat;
      case 7: return l.daySun;
      default: return '';
    }
  }

  @override
  void initState() {
    super.initState();
    _initLocal();
  }

  void _initLocal() {
    final custom = widget.store.customDailyHours;
    _local = {};
    for (int d = 1; d <= 5; d++) {
      _local[d] = custom[d] ?? widget.store.weeklyTargetHours / 5.0;
    }
  }

  String _fmt(double h) {
    // Round to nearest 5 min for clean display
    final totalMin = ((h * 60) / 5).round() * 5;
    final hours = totalMin ~/ 60;
    final minutes = totalMin % 60;
    if (minutes == 0) return '${hours}h';
    return '${hours}h${minutes.toString().padLeft(2, '0')}';
  }

  void _increment(int day) {
    setState(() {
      _local[day] = ((_local[day]! * 12).round() + 1) / 12.0;
      if (_local[day]! > 12) _local[day] = 12.0;
    });
    widget.store.setCustomDailyHours(_local);
  }

  void _decrement(int day) {
    setState(() {
      _local[day] = ((_local[day]! * 12).round() - 1) / 12.0;
      if (_local[day]! < 0) _local[day] = 0.0;
    });
    widget.store.setCustomDailyHours(_local);
  }

  @override
  Widget build(BuildContext context) {
    final hasCustom = widget.store.customDailyHours.isNotEmpty;
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() {
              _expanded = !_expanded;
              if (_expanded) _initLocal();
            }),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: WTColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: WTColors.border),
              ),
              child: Row(
                children: [
                  Text(AppLocalizations.of(context)!.weeklyDailySchedule, style: WTText.label(14)),
                  const Spacer(),
                  if (!_expanded && hasCustom)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: WTColors.accent.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.weeklyCustomized,
                        style: WTText.label(11)
                            .copyWith(color: WTColors.primary),
                      ),
                    ),
                  const SizedBox(width: 8),
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
                  ...List.generate(5, (i) {
                    final day = i + 1;
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 90,
                            child: Text(
                              _dayName(context, day),
                              style: WTText.label(14),
                            ),
                          ),
                          const Spacer(),
                          // Decrement
                          GestureDetector(
                            onTap: () => _decrement(day),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: WTColors.background,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: WTColors.border),
                              ),
                              child: const Icon(Icons.remove,
                                  size: 16,
                                  color: WTColors.secondary),
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 48,
                            child: Text(
                              _fmt(_local[day]!),
                              textAlign: TextAlign.center,
                              style: WTText.mono(16),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Increment
                          GestureDetector(
                            onTap: () => _increment(day),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: WTColors.background,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: WTColors.border),
                              ),
                              child: const Icon(Icons.add,
                                  size: 16,
                                  color: WTColors.primary),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 8),
                  // Total display
                  Container(
                    height: 1,
                    color: WTColors.border,
                    margin: const EdgeInsets.only(bottom: 12),
                  ),
                  Row(
                    children: [
                      Text(AppLocalizations.of(context)!.weeklyWeekTotal,
                          style: WTText.body(13)
                              .copyWith(color: WTColors.secondary)),
                      const Spacer(),
                      Text(
                        _fmt(_local.values
                            .fold(0.0, (a, b) => a + b)),
                        style: WTText.mono(16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Reset to uniform distribution
                  GestureDetector(
                    onTap: () {
                      widget.store.setCustomDailyHours({});
                      _initLocal();
                      setState(() {});
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      decoration: BoxDecoration(
                        color: WTColors.background,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: WTColors.border),
                      ),
                      child: Center(
                        child: Text(AppLocalizations.of(context)!.reset,
                            style: WTText.label(14)),
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

// ── Lunch Break Picker ────────────────────────────────────────────────────

class _LunchBreakPicker extends StatefulWidget {
  final WorkStore store;
  const _LunchBreakPicker({required this.store});

  @override
  State<_LunchBreakPicker> createState() => _LunchBreakPickerState();
}

class _LunchBreakPickerState extends State<_LunchBreakPicker> {
  bool _expanded = false;

  static const _options = [0, 30, 45, 60, 90, 120];

  String _label(BuildContext context, int minutes) {
    if (minutes == 0) return AppLocalizations.of(context)!.none;
    if (minutes < 60) return '$minutes min';
    final h = minutes ~/ 60;
    final m = minutes % 60;
    return m == 0 ? '${h}h' : '${h}h${m.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final current = widget.store.lunchBreakMinutes;
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
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
                  Text(AppLocalizations.of(context)!.weeklyLunchBreak, style: WTText.label(14)),
                  const Spacer(),
                  if (!_expanded)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: WTColors.orange.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _label(context, current),
                        style:
                            WTText.label(13).copyWith(color: WTColors.orange),
                      ),
                    ),
                  const SizedBox(width: 8),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.weeklyLunchBreakHint,
                    style: WTText.body(13)
                        .copyWith(color: WTColors.secondary),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _options.map((minutes) {
                      final selected = minutes == current;
                      return GestureDetector(
                        onTap: () {
                          widget.store.setLunchBreakMinutes(minutes);
                          setState(() => _expanded = false);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: selected
                                ? WTColors.orange
                                : WTColors.background,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selected
                                  ? WTColors.orange
                                  : WTColors.border,
                            ),
                          ),
                          child: Text(
                            _label(context, minutes),
                            style: WTText.label(14).copyWith(
                              color: selected
                                  ? WTColors.surface
                                  : WTColors.primary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
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
                  Text(AppLocalizations.of(context)!.weeklyTargetEdit,
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
                      Text(AppLocalizations.of(context)!.weeklyCurrentTarget,
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
                        child: Text(AppLocalizations.of(context)!.save, style: WTText.label(15)),
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
