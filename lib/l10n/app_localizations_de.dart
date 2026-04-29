// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Working Time';

  @override
  String get tabHome => 'Start';

  @override
  String get tabWeek => 'Woche';

  @override
  String get tabHistory => 'Verlauf';

  @override
  String get onboardingSubtitle =>
      'Richten Sie Ihre woechentliche\nArbeitszeit ein.';

  @override
  String get onboardingPerWeek => 'PRO WOCHE';

  @override
  String get onboardingStart => 'Loslegen';

  @override
  String get homeStatusPaused => 'IN PAUSE';

  @override
  String get homeStatusActive => 'IN ARBEIT';

  @override
  String get homeStatusWeekly => 'WOCHE';

  @override
  String homePauseContext(String pauseDuration, String arrival) {
    return 'Pause $pauseDuration  -  seit $arrival';
  }

  @override
  String homeArrivalSince(String arrival) {
    return 'seit $arrival';
  }

  @override
  String homeObjective(String target) {
    return 'Ziel $target';
  }

  @override
  String get homeReadyToClockIn => 'Bereit einzustempeln';

  @override
  String get homeModeDaily => 'Taeglich';

  @override
  String get homeModeWeekly => 'Woechentlich';

  @override
  String get homeResume => 'Arbeit fortsetzen';

  @override
  String get homePause => 'Pause machen';

  @override
  String get homeClockOut => 'Ausstempeln';

  @override
  String get homeClockIn => 'Einstempeln';

  @override
  String get homeExpectedDeparture => 'GEP. ABFAHRT';

  @override
  String get homeWeekLabel => 'WOCHE';

  @override
  String get homeClockOutTitle => 'Ausstempeln';

  @override
  String get homeClockOutConfirm =>
      'Moechten Sie Ihre Abgangszeit wirklich erfassen?';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get confirm => 'Bestaetigen';

  @override
  String get weeklyTitle => 'DIESE\nWOCHE';

  @override
  String get weeklyObjectiveLabel => 'Ziel';

  @override
  String get weeklyWorked => 'Gearbeitet';

  @override
  String get weeklyObjective => 'Ziel';

  @override
  String get weeklyOvertime => 'Ueberstunden';

  @override
  String get weeklyRemaining => 'Verbleibend';

  @override
  String get weeklyDays => 'Tage';

  @override
  String get weeklySettings => 'EINSTELLUNGEN';

  @override
  String get weeklyObjectiveMode => 'Zielmodus';

  @override
  String get weeklyDailyProgressDesc => 'Fortschritt fuer den aktuellen Tag';

  @override
  String get weeklyWeekProgressDesc => 'Fortschritt fuer die gesamte Woche';

  @override
  String get weeklyModeDay => 'Tag';

  @override
  String get weeklyModeWeek => 'Woche';

  @override
  String get weeklyToday => 'Heute';

  @override
  String get weeklyDailySchedule => 'Stundenplan pro Tag';

  @override
  String get weeklyCustomized => 'Angepasst';

  @override
  String get weeklyWeekTotal => 'Wochengesamt';

  @override
  String get reset => 'Zuruecksetzen';

  @override
  String get weeklyLunchBreak => 'Mittagspause';

  @override
  String get weeklyLunchBreakHint =>
      'Pausendauer zur Abfahrtszeit hinzugefuegt';

  @override
  String get none => 'Keine';

  @override
  String get weeklyTargetEdit => 'Wochenziel aendern';

  @override
  String get weeklyCurrentTarget => 'Aktuelles Ziel';

  @override
  String get save => 'Speichern';

  @override
  String get historyTitle => 'VERLAUF';

  @override
  String get historyEmpty => 'Kein Verlauf';

  @override
  String get historyEmptySubtitle => 'Ihre Arbeitstage\nwerden hier angezeigt.';

  @override
  String historyPauses(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Pausen',
      one: '1 Pause',
    );
    return '$_temp0';
  }

  @override
  String get dayMon => 'Montag';

  @override
  String get dayTue => 'Dienstag';

  @override
  String get dayWed => 'Mittwoch';

  @override
  String get dayThu => 'Donnerstag';

  @override
  String get dayFri => 'Freitag';

  @override
  String get daySat => 'Samstag';

  @override
  String get daySun => 'Sonntag';

  @override
  String get legalTitle => 'Rechtliches';

  @override
  String get termsTitle => 'Nutzungsbedingungen';

  @override
  String get privacyTitle => 'Datenschutzerklaerung';

  @override
  String get legalLinkText => 'Nutzungsbedingungen und Datenschutzerklaerung';

  @override
  String get termsContent =>
      'Nutzungsbedingungen\n\nLetzte Aktualisierung: 29. April 2026\n\n1. Akzeptanz\nDurch die Nutzung von Working Time stimmen Sie diesen Nutzungsbedingungen zu.\n\n2. Beschreibung des Dienstes\nWorking Time ist eine mobile App zur Arbeitszeitverfolgung.\n\n3. Persoenliche Nutzung\nDie App ist ausschliesslich fuer den persoenlichen, nicht-kommerziellen Gebrauch bestimmt.\n\n4. Lokale Daten\nAlle Ihre Daten werden nur auf Ihrem Geraet gespeichert. Wir erheben keine Daten auf externen Servern.\n\n5. Haftungsbeschraenkung\nWorking Time wird bereitgestellt wie es ist. Wir uebernehmen keine Garantie fuer die Richtigkeit der Berechnungen fuer rechtliche Zwecke.\n\n6. Aenderungen\nWir behalten uns das Recht vor, diese Bedingungen jederzeit zu aendern.\n\n7. Kontakt\nFuer Fragen kontaktieren Sie uns ueber den App Store.';

  @override
  String get privacyContent =>
      'Datenschutzerklaerung\n\nLetzte Aktualisierung: 29. April 2026\n\n1. Erhobene Daten\nWorking Time erhebt keine personenbezogenen Daten. Alle Informationen werden lokal auf Ihrem Geraet gespeichert.\n\n2. Datenweitergabe\nEs werden keine Daten an Dritte weitergegeben.\n\n3. Berechtigungen\nDie App kann den Zugriff auf Benachrichtigungen anfordern.\n\n4. Sicherheit\nIhre Daten sind durch die Sicherheitsmechanismen Ihres Geraets geschuetzt.\n\n5. Datenloeschung\nSie koennen alle Ihre Daten jederzeit loeschen, indem Sie die App deinstallieren.\n\n6. Kinder\nDiese App ist nicht fuer Kinder unter 13 Jahren bestimmt.\n\n7. Kontakt\nFuer datenschutzbezogene Fragen kontaktieren Sie uns ueber den App Store.';
}
