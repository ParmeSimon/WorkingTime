import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

import 'store/work_store.dart';
import 'theme/app_theme.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/weekly_screen.dart';
import 'screens/history_screen.dart';
import 'services/notification_service.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Initialize French locale for date formatting
  await initializeDateFormatting('fr_FR', null);

  // Initialize timezone database and set device local timezone
  tz.initializeTimeZones();
  try {
    final deviceTz = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(deviceTz.identifier));
  } catch (_) {
    // Fallback: keep UTC if timezone detection fails
  }

  // Initialize notifications
  await NotificationService.init();
  await NotificationService.requestPermissions();

  // Load persisted data
  final store = WorkStore();
  await store.load();

  runApp(
    ChangeNotifierProvider.value(
      value: store,
      child: const WorkingTimeApp(),
    ),
  );
}

class WorkingTimeApp extends StatelessWidget {
  const WorkingTimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Working Time',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const _RootShell(),
    );
  }
}

// ── Root Shell — handles onboarding vs main shell ─────────────────────────

class _RootShell extends StatelessWidget {
  const _RootShell();

  @override
  Widget build(BuildContext context) {
    final onboarded = context.watch<WorkStore>().hasCompletedOnboarding;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: onboarded
          ? const _MainShell(key: ValueKey('main'))
          : const OnboardingScreen(key: ValueKey('onboarding')),
    );
  }
}

// ── Main Shell — custom bottom navigation ─────────────────────────────────

class _MainShell extends StatefulWidget {
  const _MainShell({super.key});

  @override
  State<_MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<_MainShell> {
  int _currentIndex = 0;

  static const _screens = [
    HomeScreen(),
    WeeklyScreen(),
    HistoryScreen(),
  ];

  static const _tabs = [
    _TabItem(icon: Icons.radio_button_checked_rounded, label: 'Accueil'),
    _TabItem(icon: Icons.bar_chart_rounded, label: 'Semaine'),
    _TabItem(icon: Icons.access_time_rounded, label: 'Historique'),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: WTColors.background,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: WTColors.surface,
          border: Border(top: BorderSide(color: WTColors.border)),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: Row(
            children: List.generate(_tabs.length, (i) {
              final tab = _tabs[i];
              final isSelected = _currentIndex == i;
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setState(() => _currentIndex = i),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? WTColors.accent
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            tab.icon,
                            size: 18,
                            color: isSelected
                                ? WTColors.primary
                                : WTColors.secondary.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tab.label,
                          style: WTText.label(10).copyWith(
                            color: isSelected
                                ? WTColors.primary
                                : WTColors.secondary.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _TabItem {
  final IconData icon;
  final String label;
  const _TabItem({required this.icon, required this.label});
}
