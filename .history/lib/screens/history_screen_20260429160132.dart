import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../store/work_store.dart';
import '../theme/app_theme.dart';
import '../widgets/arc_progress_ring.dart';
import '../widgets/tag_pill.dart';
import '../models/work_session.dart';
import '../l10n/app_localizations.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final Set<String> _expandedWeeks = {};

  @override
  void initState() {
    super.initState();
    // Auto-expand current week on first load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final store = context.read<WorkStore>();
      if (store.weeksWithData.isNotEmpty) {
        setState(() {
          _expandedWeeks.add(store.weeksWithData.first.toIso8601String());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<WorkStore>();
    final weeks = store.weeksWithData;

    return Scaffold(
      backgroundColor: WTColors.background,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // ── Title ───────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
                child: Text(AppLocalizations.of(context)!.historyTitle, style: WTText.display(38)),
              ),
            ),

            // ── Content ─────────────────────────────────────────────
            if (weeks.isEmpty)
              const SliverToBoxAdapter(child: _EmptyState())
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, idx) {
                    final weekStart = weeks[idx];
                    final weekKey = weekStart.toIso8601String();
                    final sessions = store.sessionsForWeek(weekStart);
                    final isExpanded = _expandedWeeks.contains(weekKey);

                    return _WeekSection(
                      weekStart: weekStart,
                      sessions: sessions,
                      weeklyTarget: store.weeklyTargetHours,
                      isExpanded: isExpanded,
                      onToggle: () => setState(() {
                        if (isExpanded) {
                          _expandedWeeks.remove(weekKey);
                        } else {
                          _expandedWeeks.add(weekKey);
                        }
                      }),
                      onDelete: (id) => store.deleteSession(id),
                    );
                  },
                  childCount: weeks.length,
                ),
              ),

            const SliverToBoxAdapter(child: SizedBox(height: 60)),
          ],
        ),
      ),
    );
  }
}

// ── Empty State ───────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Column(
        children: [
          Icon(Icons.access_time_rounded,
              size: 56, color: WTColors.secondary.withOpacity(0.3)),
          const SizedBox(height: 16),
          Text(AppLocalizations.of(context)!.historyEmpty,
              style: WTText.heading(20)
                  .copyWith(color: WTColors.secondary)),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.historyEmptySubtitle,
            style: WTText.body(15)
                .copyWith(color: WTColors.secondary.withOpacity(0.6)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ── Week Section ──────────────────────────────────────────────────────────

class _WeekSection extends StatelessWidget {
  final DateTime weekStart;
  final List<WorkSession> sessions;
  final double weeklyTarget;
  final bool isExpanded;
  final VoidCallback onToggle;
  final void Function(String id) onDelete;

  const _WeekSection({
    required this.weekStart,
    required this.sessions,
    required this.weeklyTarget,
    required this.isExpanded,
    required this.onToggle,
    required this.onDelete,
  });

  Duration get _total => sessions
      .map((s) => s.duration ?? Duration.zero)
      .fold(Duration.zero, (a, b) => a + b);

  double get _progress {
    final target = weeklyTarget * 3600;
    if (target == 0) return 0;
    return (_total.inSeconds / target).clamp(0.0, 1.0);
  }

  bool get _isOver => _total.inSeconds > weeklyTarget * 3600;

  String _fmt(Duration d) {
    return '${d.inHours}h${d.inMinutes.remainder(60).toString().padLeft(2, '0')}';
  }

  String _weekRange() {
    final end = weekStart.add(const Duration(days: 6));
    final f = DateFormat('d MMM', 'fr_FR');
    return '${f.format(weekStart)} – ${f.format(end)}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        GestureDetector(
          onTap: onToggle,
          child: Container(
            color: WTColors.surface,
            padding:
                const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
            child: Row(
              children: [
                // Mini ring
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ArcProgressRing(
                      progress: _progress,
                      size: 40,
                      strokeWidth: 4,
                      foreground:
                          _isOver ? WTColors.accent : WTColors.primary,
                      background: WTColors.border,
                    ),
                    Text(
                      '${(_progress * 100).round()}%',
                      style: const TextStyle(
                          fontSize: 8, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const SizedBox(width: 16),

                // Range + duration
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_weekRange(), style: WTText.label(14)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(_fmt(_total), style: WTText.mono(13)),
                          Text(
                            ' / ${_fmt(Duration(seconds: (weeklyTarget * 3600).round()))}',
                            style: WTText.body(13)
                                .copyWith(color: WTColors.secondary),
                          ),
                          if (_isOver) ...[
                            const SizedBox(width: 8),
                            TagPill(
                              text:
                                  '+${_fmt(_total - Duration(seconds: (weeklyTarget * 3600).round()))}',
                              color: WTColors.accent,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: WTColors.secondary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),

        // Session rows (animated)
        AnimatedSize(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeInOut,
          child: isExpanded
              ? Column(
                  children: (sessions.toList()
                        ..sort((a, b) =>
                            b.arrivalTime.compareTo(a.arrivalTime)))
                      .map((s) => _SessionRow(
                            session: s,
                            onDelete: () => onDelete(s.id),
                          ))
                      .toList(),
                )
              : const SizedBox.shrink(),
        ),

        Container(height: 1, color: WTColors.border),
      ],
    );
  }
}

// ── Session Row ───────────────────────────────────────────────────────────

class _SessionRow extends StatelessWidget {
  final WorkSession session;
  final VoidCallback onDelete;

  const _SessionRow({required this.session, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final arrival = DateFormat('HH:mm').format(session.arrivalTime);
    final departure = session.departureTime != null
        ? DateFormat('HH:mm').format(session.departureTime!)
        : '--:--';
    final dayLabel = DateFormat('EEE d MMM', 'fr_FR').format(session.arrivalTime);

    return Dismissible(
      key: Key(session.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: WTColors.red.withOpacity(0.1),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Icon(Icons.delete_outline, color: WTColors.red),
      ),
      onDismissed: (_) => onDelete(),
      child: Container(
        color: WTColors.background,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        child: Row(
          children: [
            // Dot
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: WTColors.border,
              ),
            ),
            const SizedBox(width: 16),

            // Date + times
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dayLabel[0].toUpperCase() + dayLabel.substring(1),
                    style: WTText.label(13),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$arrival → $departure',
                    style: WTText.mono(12)
                        .copyWith(color: WTColors.secondary),
                  ),
                ],
              ),
            ),

            // Duration + pause pill
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  session.formattedDuration,
                  style: WTText.mono(15),
                ),
                if (session.pauses.isNotEmpty &&
                    session.departureTime != null) ...[
                  const SizedBox(height: 3),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: WTColors.orange.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${session.pauses.length} pause${session.pauses.length > 1 ? 's' : ''}',
                      style: WTText.body(10)
                          .copyWith(color: WTColors.orange),
                    ),
                  ),
                ],
              ],
            ),

            // Delete button
            IconButton(
              icon: const Icon(Icons.delete_outline,
                  color: WTColors.secondary, size: 18),
              onPressed: onDelete,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}
