// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Working Time';

  @override
  String get tabHome => 'Home';

  @override
  String get tabWeek => 'Week';

  @override
  String get tabHistory => 'History';

  @override
  String get onboardingSubtitle => 'Set up your weekly\nwork schedule.';

  @override
  String get onboardingPerWeek => 'PER WEEK';

  @override
  String get onboardingStart => 'Get Started';

  @override
  String get homeStatusPaused => 'ON BREAK';

  @override
  String get homeStatusActive => 'IN PROGRESS';

  @override
  String get homeStatusWeekly => 'WEEK';

  @override
  String homePauseContext(String pauseDuration, String arrival) {
    return 'break $pauseDuration  •  since $arrival';
  }

  @override
  String homeArrivalSince(String arrival) {
    return 'since $arrival';
  }

  @override
  String homeObjective(String target) {
    return 'goal $target';
  }

  @override
  String get homeReadyToClockIn => 'Ready to clock in';

  @override
  String get homeModeDaily => 'Daily';

  @override
  String get homeModeWeekly => 'Weekly';

  @override
  String get homeResume => 'Resume work';

  @override
  String get homePause => 'Take a break';

  @override
  String get homeClockOut => 'Clock out';

  @override
  String get homeClockIn => 'Clock in';

  @override
  String get homeExpectedDeparture => 'EST. DEPARTURE';

  @override
  String get homeWeekLabel => 'WEEK';

  @override
  String get homeClockOutTitle => 'Clock Out';

  @override
  String get homeClockOutConfirm =>
      'Are you sure you want to record your departure time?';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get weeklyTitle => 'THIS\nWEEK';

  @override
  String get weeklyObjectiveLabel => 'goal';

  @override
  String get weeklyWorked => 'Worked';

  @override
  String get weeklyObjective => 'Goal';

  @override
  String get weeklyOvertime => 'Overtime';

  @override
  String get weeklyRemaining => 'Remaining';

  @override
  String get weeklyDays => 'Days';

  @override
  String get weeklySettings => 'SETTINGS';

  @override
  String get weeklyObjectiveMode => 'Objective mode';

  @override
  String get weeklyDailyProgressDesc => 'Progress for the current day';

  @override
  String get weeklyWeekProgressDesc => 'Progress for the entire week';

  @override
  String get weeklyModeDay => 'Day';

  @override
  String get weeklyModeWeek => 'Week';

  @override
  String get weeklyToday => 'Today';

  @override
  String get weeklyDailySchedule => 'Schedule per day';

  @override
  String get weeklyCustomized => 'Custom';

  @override
  String get weeklyWeekTotal => 'Week total';

  @override
  String get reset => 'Reset';

  @override
  String get weeklyLunchBreak => 'Lunch break';

  @override
  String get weeklyLunchBreakHint =>
      'Break duration added to your departure time';

  @override
  String get none => 'None';

  @override
  String get weeklyTargetEdit => 'Edit weekly goal';

  @override
  String get weeklyCurrentTarget => 'Current goal';

  @override
  String get save => 'Save';

  @override
  String get historyTitle => 'HISTORY';

  @override
  String get historyEmpty => 'No history yet';

  @override
  String get historyEmptySubtitle => 'Your work days\nwill appear here.';

  @override
  String historyPauses(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count breaks',
      one: '1 break',
    );
    return '$_temp0';
  }

  @override
  String get dayMon => 'Monday';

  @override
  String get dayTue => 'Tuesday';

  @override
  String get dayWed => 'Wednesday';

  @override
  String get dayThu => 'Thursday';

  @override
  String get dayFri => 'Friday';

  @override
  String get daySat => 'Saturday';

  @override
  String get daySun => 'Sunday';

  @override
  String get legalTitle => 'Legal';

  @override
  String get termsTitle => 'Terms of Use';

  @override
  String get privacyTitle => 'Privacy Policy';

  @override
  String get legalLinkText => 'Terms of Use & Privacy Policy';

  @override
  String get termsContent =>
      'Terms of Use\n\nLast updated: April 29, 2026\n\n1. Acceptance\nBy using Working Time, you agree to these terms of use. If you do not agree, please do not use the app.\n\n2. Service Description\nWorking Time is a mobile app for tracking work time. It lets you log arrival and departure times, breaks, and view weekly statistics.\n\n3. Personal Use\nThe app is for personal, non-commercial use only. You agree not to use it for illegal or harmful purposes.\n\n4. Local Data\nAll your data (sessions, settings) is stored only on your device. We do not collect data on remote servers.\n\n5. Limitation of Liability\nWorking Time is provided \"as is\". We do not guarantee the accuracy of calculations for legal or contractual purposes. The app does not replace an official timekeeping system.\n\n6. Changes\nWe reserve the right to modify these terms at any time. Changes will be communicated through app updates.\n\n7. Contact\nFor questions, contact us via the App Store.';

  @override
  String get privacyContent =>
      'Privacy Policy\n\nLast updated: April 29, 2026\n\n1. Data Collected\nWorking Time does not collect any personal data. All information (work hours, settings, history) is stored locally on your device using your operating system\'s secure storage.\n\n2. Data Sharing\nNo data is shared with third parties. We have no access to any of your information.\n\n3. Permissions\nThe app may request notification access to send you clock-in reminders. These notifications remain local to your device.\n\n4. Security\nYour data is protected by your device\'s security mechanisms (encryption, biometric access, etc.).\n\n5. Data Deletion\nYou can delete all your data at any time from the app settings or by uninstalling the app.\n\n6. Children\nThis app is not intended for children under 13.\n\n7. Changes\nWe reserve the right to modify this policy. Changes will be communicated through app updates.\n\n8. Contact\nFor privacy-related questions, contact us via the App Store.';
}
