// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Working Time';

  @override
  String get tabHome => 'Home';

  @override
  String get tabWeek => 'Settimana';

  @override
  String get tabHistory => 'Cronologia';

  @override
  String get onboardingSubtitle =>
      'Configura il tuo orario\ndi lavoro settimanale.';

  @override
  String get onboardingPerWeek => 'ALLA SETTIMANA';

  @override
  String get onboardingStart => 'Inizia';

  @override
  String get homeStatusPaused => 'IN PAUSA';

  @override
  String get homeStatusActive => 'IN CORSO';

  @override
  String get homeStatusWeekly => 'SETTIMANA';

  @override
  String homePauseContext(String pauseDuration, String arrival) {
    return 'pausa $pauseDuration  •  dalle $arrival';
  }

  @override
  String homeArrivalSince(String arrival) {
    return 'dalle $arrival';
  }

  @override
  String homeObjective(String target) {
    return 'obiettivo $target';
  }

  @override
  String get homeReadyToClockIn => 'Pronto per timbrare';

  @override
  String get homeModeDaily => 'Giornaliero';

  @override
  String get homeModeWeekly => 'Settimanale';

  @override
  String get homeResume => 'Riprendi il lavoro';

  @override
  String get homePause => 'Pausa';

  @override
  String get homeClockOut => 'Timbra uscita';

  @override
  String get homeClockIn => 'Timbra entrata';

  @override
  String get homeExpectedDeparture => 'USCITA PREVISTA';

  @override
  String get homeWeekLabel => 'SETTIMANA';

  @override
  String get homeClockOutTitle => 'Timbra uscita';

  @override
  String get homeClockOutConfirm =>
      'Sei sicuro di voler registrare l\'ora di uscita?';

  @override
  String get cancel => 'Annulla';

  @override
  String get confirm => 'Conferma';

  @override
  String get weeklyTitle => 'QUESTA\nSETTIMANA';

  @override
  String get weeklyObjectiveLabel => 'obiettivo';

  @override
  String get weeklyWorked => 'Lavorato';

  @override
  String get weeklyObjective => 'Obiettivo';

  @override
  String get weeklyOvertime => 'Straordinari';

  @override
  String get weeklyRemaining => 'Rimanente';

  @override
  String get weeklyDays => 'Giorni';

  @override
  String get weeklySettings => 'IMPOSTAZIONI';

  @override
  String get weeklyObjectiveMode => 'Modalità obiettivo';

  @override
  String get weeklyDailyProgressDesc => 'Progresso del giorno in corso';

  @override
  String get weeklyWeekProgressDesc => 'Progresso dell\'intera settimana';

  @override
  String get weeklyModeDay => 'Giorno';

  @override
  String get weeklyModeWeek => 'Settimana';

  @override
  String get weeklyToday => 'Oggi';

  @override
  String get weeklyDailySchedule => 'Orario per giorno';

  @override
  String get weeklyCustomized => 'Personalizzato';

  @override
  String get weeklyWeekTotal => 'Totale settimanale';

  @override
  String get reset => 'Reimposta';

  @override
  String get weeklyLunchBreak => 'Pausa pranzo';

  @override
  String get weeklyLunchBreakHint => 'Durata pausa aggiunta all\'ora di uscita';

  @override
  String get none => 'Nessuna';

  @override
  String get weeklyTargetEdit => 'Modifica obiettivo settimanale';

  @override
  String get weeklyCurrentTarget => 'Obiettivo attuale';

  @override
  String get save => 'Salva';

  @override
  String get historyTitle => 'CRONOLOGIA';

  @override
  String get historyEmpty => 'Nessuna cronologia';

  @override
  String get historyEmptySubtitle =>
      'Le tue giornate lavorative\nappariranno qui.';

  @override
  String historyPauses(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pause',
      one: '1 pausa',
    );
    return '$_temp0';
  }

  @override
  String get dayMon => 'Lunedì';

  @override
  String get dayTue => 'Martedì';

  @override
  String get dayWed => 'Mercoledì';

  @override
  String get dayThu => 'Giovedì';

  @override
  String get dayFri => 'Venerdì';

  @override
  String get daySat => 'Sabato';

  @override
  String get daySun => 'Domenica';

  @override
  String get legalTitle => 'Legale';

  @override
  String get termsTitle => 'Termini di utilizzo';

  @override
  String get privacyTitle => 'Informativa sulla privacy';

  @override
  String get legalLinkText => 'Termini di utilizzo e Informativa sulla privacy';

  @override
  String get termsContent =>
      'Termini di utilizzo\n\nUltimo aggiornamento: 29 aprile 2026\n\n1. Accettazione\nUsando Working Time, accetti questi termini di utilizzo.\n\n2. Descrizione del servizio\nWorking Time è un\'app mobile per il monitoraggio del tempo di lavoro.\n\n3. Uso personale\nL\'app è destinata solo all\'uso personale e non commerciale.\n\n4. Dati locali\nTutti i tuoi dati sono archiviati solo sul tuo dispositivo. Non raccogliamo dati su server remoti.\n\n5. Limitazione di responsabilità\nWorking Time viene fornito \"così com\'è\". Non garantiamo l\'accuratezza dei calcoli per scopi legali.\n\n6. Modifiche\nCi riserviamo il diritto di modificare questi termini in qualsiasi momento.\n\n7. Contatto\nPer domande, contattaci tramite l\'App Store.';

  @override
  String get privacyContent =>
      'Informativa sulla privacy\n\nUltimo aggiornamento: 29 aprile 2026\n\n1. Dati raccolti\nWorking Time non raccoglie dati personali. Tutte le informazioni sono archiviate localmente sul tuo dispositivo.\n\n2. Condivisione dei dati\nNessun dato viene condiviso con terze parti.\n\n3. Autorizzazioni\nL\'app può richiedere l\'accesso alle notifiche per inviarti promemoria.\n\n4. Sicurezza\nI tuoi dati sono protetti dai meccanismi di sicurezza del tuo dispositivo.\n\n5. Eliminazione dei dati\nPuoi eliminare tutti i tuoi dati disinstallando l\'app.\n\n6. Minori\nQuesta app non è destinata ai minori di 13 anni.\n\n7. Contatto\nPer domande sulla privacy, contattaci tramite l\'App Store.';
}
