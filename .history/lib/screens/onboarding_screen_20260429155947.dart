import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../store/work_store.dart';
import '../theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import 'legal_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  double _targetHours = 35.0;
  late AnimationController _ctrl;
  late Animation<double> _fadeSlide;

  static const _presets = [35.0, 37.5, 39.0, 40.0];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    _fadeSlide = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  String _formatPreset(double h) {
    if (h % 1 == 0) return '${h.toInt()}h';
    return '${h}h';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WTColors.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeSlide,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.06),
              end: Offset.zero,
            ).animate(_fadeSlide),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ───────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 48, 28, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // AJOUT DU LOGO ICI
                      Image.asset(
                        'assets/images/WorkingTime.png',
                        width: 80,
                        height: 80,
                      ),
                      const SizedBox(height: 24), // Espace entre le logo et le titre

                      Text('WORKING\nTIME', style: WTText.display(52)),
                      const SizedBox(height: 14),
                      Text(
                        AppLocalizations.of(context)!.onboardingSubtitle,
                        style: WTText.body(17).copyWith(
                          color: WTColors.secondary,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // ── Big number ───────────────────────────────────────────
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder: (child, anim) =>
                            FadeTransition(opacity: anim, child: child),
                        child: Text(
                          _targetHours % 1 == 0
                              ? '${_targetHours.toInt()}'
                              : '$_targetHours',
                          key: ValueKey(_targetHours),
                          style: WTText.display(96),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          'h',
                          style: WTText.display(40)
                              .copyWith(color: WTColors.secondary),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.onboardingPerWeek,
                    style: WTText.caps(12),
                  ),
                ),

                const Spacer(),

                // ── Slider ───────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: WTColors.primary,
                      inactiveTrackColor: WTColors.border,
                      thumbColor: WTColors.primary,
                      overlayColor: WTColors.primary.withOpacity(0.08),
                      trackHeight: 3,
                    ),
                    child: Slider(
                      value: _targetHours,
                      min: 20,
                      max: 50,
                      divisions: 60,
                      onChanged: (v) => setState(() => _targetHours = v),
                    ),
                  ),
                ),

                // ── Preset pills ─────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Row(
                    children: _presets
                        .map((h) => Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: _PresetPill(
                                label: _formatPreset(h),
                                selected: _targetHours == h,
                                onTap: () =>
                                    setState(() => _targetHours = h),
                              ),
                            ))
                        .toList(),
                  ),
                ),

                const Spacer(),

                // ── CTA ──────────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                  child: GestureDetector(
                    onTap: () {
                      context
                          .read<WorkStore>()
                          .setWeeklyTarget(_targetHours);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 20),
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
                          Text(
                            AppLocalizations.of(context)!.onboardingStart,
                            style: WTText.label(17)
                                .copyWith(color: WTColors.surface),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward,
                            color: WTColors.accent,
                            size: 22,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PresetPill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _PresetPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? WTColors.accent : WTColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? Colors.transparent : WTColors.border,
          ),
        ),
        child: Text(
          label,
          style: WTText.label(14).copyWith(
            color: selected ? WTColors.primary : WTColors.secondary,
          ),
        ),
      ),
    );
  }
}
