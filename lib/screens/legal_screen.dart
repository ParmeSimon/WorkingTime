import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../l10n/app_localizations.dart';

class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: WTColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top bar ──────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 28, 0),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    size: 20, color: WTColors.primary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 8, 28, 32),
              child: Text(l.legalTitle, style: WTText.display(38)),
            ),

            // ── Content ──────────────────────────────────────────────
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    // Tab bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Container(
                        decoration: BoxDecoration(
                          color: WTColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: WTColors.border),
                        ),
                        child: TabBar(
                          dividerColor: Colors.transparent,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                            color: WTColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelColor: WTColors.surface,
                          unselectedLabelColor: WTColors.secondary,
                          labelStyle: WTText.label(13),
                          unselectedLabelStyle: WTText.label(13),
                          tabs: [
                            Tab(text: l.termsTitle),
                            Tab(text: l.privacyTitle),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Tab content
                    Expanded(
                      child: TabBarView(
                        children: [
                          _LegalPage(content: l.termsContent),
                          _LegalPage(content: l.privacyContent),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LegalPage extends StatelessWidget {
  final String content;
  const _LegalPage({required this.content});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(28, 0, 28, 40),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: WTColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: WTColors.border),
        ),
        child: Text(
          content,
          style: WTText.body(14).copyWith(height: 1.7),
        ),
      ),
    );
  }
}
