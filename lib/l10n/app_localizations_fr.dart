// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Working Time';

  @override
  String get tabHome => 'Accueil';

  @override
  String get tabWeek => 'Semaine';

  @override
  String get tabHistory => 'Historique';

  @override
  String get onboardingSubtitle =>
      'Configurez votre temps de\ntravail hebdomadaire.';

  @override
  String get onboardingPerWeek => 'PAR SEMAINE';

  @override
  String get onboardingStart => 'Commencer';

  @override
  String get homeStatusPaused => 'EN PAUSE';

  @override
  String get homeStatusActive => 'EN COURS';

  @override
  String get homeStatusWeekly => 'SEMAINE';

  @override
  String homePauseContext(String pauseDuration, String arrival) {
    return 'pause $pauseDuration  •  depuis $arrival';
  }

  @override
  String homeArrivalSince(String arrival) {
    return 'depuis $arrival';
  }

  @override
  String homeObjective(String target) {
    return 'objectif $target';
  }

  @override
  String get homeReadyToClockIn => 'Prêt à pointer';

  @override
  String get homeModeDaily => 'Journalier';

  @override
  String get homeModeWeekly => 'Hebdomadaire';

  @override
  String get homeResume => 'Reprendre le travail';

  @override
  String get homePause => 'Mettre en pause';

  @override
  String get homeClockOut => 'Pointer ma sortie';

  @override
  String get homeClockIn => 'Pointer mon arrivée';

  @override
  String get homeExpectedDeparture => 'DÉPART PRÉVU';

  @override
  String get homeWeekLabel => 'SEMAINE';

  @override
  String get homeClockOutTitle => 'Pointer la sortie';

  @override
  String get homeClockOutConfirm =>
      'Êtes-vous sûr de vouloir enregistrer votre heure de sortie ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirm => 'Confirmer';

  @override
  String get weeklyTitle => 'CETTE\nSEMAINE';

  @override
  String get weeklyObjectiveLabel => 'objectif';

  @override
  String get weeklyWorked => 'Travaillé';

  @override
  String get weeklyObjective => 'Objectif';

  @override
  String get weeklyOvertime => 'Heures sup.';

  @override
  String get weeklyRemaining => 'Restant';

  @override
  String get weeklyDays => 'Journées';

  @override
  String get weeklySettings => 'PARAMÈTRES';

  @override
  String get weeklyObjectiveMode => 'Mode d\'objectif';

  @override
  String get weeklyDailyProgressDesc => 'Progression sur la journée en cours';

  @override
  String get weeklyWeekProgressDesc => 'Progression sur la semaine entière';

  @override
  String get weeklyModeDay => 'Jour';

  @override
  String get weeklyModeWeek => 'Semaine';

  @override
  String get weeklyToday => 'Auj.';

  @override
  String get weeklyDailySchedule => 'Horaires par jour';

  @override
  String get weeklyCustomized => 'Personnalisé';

  @override
  String get weeklyWeekTotal => 'Total semaine';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get weeklyLunchBreak => 'Pause déjeuner';

  @override
  String get weeklyLunchBreakHint =>
      'Durée de pause ajoutée à votre heure de départ';

  @override
  String get none => 'Aucune';

  @override
  String get weeklyTargetEdit => 'Modifier l\'objectif hebdomadaire';

  @override
  String get weeklyCurrentTarget => 'Objectif actuel';

  @override
  String get save => 'Enregistrer';

  @override
  String get historyTitle => 'HISTORIQUE';

  @override
  String get historyEmpty => 'Aucun historique';

  @override
  String get historyEmptySubtitle =>
      'Vos journées de travail\napparaîtront ici.';

  @override
  String historyPauses(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pauses',
      one: '1 pause',
    );
    return '$_temp0';
  }

  @override
  String get dayMon => 'Lundi';

  @override
  String get dayTue => 'Mardi';

  @override
  String get dayWed => 'Mercredi';

  @override
  String get dayThu => 'Jeudi';

  @override
  String get dayFri => 'Vendredi';

  @override
  String get daySat => 'Samedi';

  @override
  String get daySun => 'Dimanche';

  @override
  String get legalTitle => 'Légal';

  @override
  String get termsTitle => 'Conditions d\'utilisation';

  @override
  String get privacyTitle => 'Politique de confidentialité';

  @override
  String get legalLinkText =>
      'Conditions d\'utilisation & Politique de confidentialité';

  @override
  String get termsContent =>
      'Conditions d\'utilisation\n\nDernière mise à jour : 29 avril 2026\n\n1. Acceptation des conditions\nEn utilisant Working Time, vous acceptez les présentes conditions d\'utilisation. Si vous n\'acceptez pas ces conditions, veuillez ne pas utiliser l\'application.\n\n2. Description du service\nWorking Time est une application mobile de suivi du temps de travail. Elle vous permet d\'enregistrer vos heures d\'arrivée et de départ, vos pauses et de visualiser vos statistiques hebdomadaires.\n\n3. Utilisation personnelle\nL\'application est destinée à un usage personnel et non commercial. Vous vous engagez à ne pas utiliser l\'application à des fins illégales ou nuisibles.\n\n4. Données locales\nToutes vos données (sessions, paramètres) sont stockées uniquement sur votre appareil. Nous ne collectons aucune donnée sur des serveurs distants.\n\n5. Limitation de responsabilité\nWorking Time est fournie « en l\'état ». Nous ne garantissons pas l\'exactitude des calculs à des fins légales ou contractuelles. L\'application ne remplace pas un système officiel de pointage.\n\n6. Modifications\nNous nous réservons le droit de modifier ces conditions à tout moment. Les modifications seront notifiées via une mise à jour de l\'application.\n\n7. Contact\nPour toute question, contactez-nous via l\'App Store.';

  @override
  String get privacyContent =>
      'Politique de confidentialité\n\nDernière mise à jour : 29 avril 2026\n\n1. Données collectées\nWorking Time ne collecte aucune donnée personnelle. Toutes les informations (heures de travail, paramètres, historique) sont stockées localement sur votre appareil via le stockage sécurisé de votre système d\'exploitation.\n\n2. Partage des données\nAucune donnée n\'est partagée avec des tiers. Nous n\'avons accès à aucune de vos informations.\n\n3. Permissions\nL\'application peut demander l\'accès aux notifications pour vous envoyer des rappels de pointage. Ces notifications restent locales à votre appareil.\n\n4. Sécurité\nVos données sont protégées par les mécanismes de sécurité de votre appareil (chiffrement, accès biométrique, etc.).\n\n5. Suppression des données\nVous pouvez supprimer toutes vos données à tout moment depuis les paramètres de l\'application ou en désinstallant l\'application.\n\n6. Enfants\nCette application n\'est pas destinée aux enfants de moins de 13 ans.\n\n7. Modifications\nNous nous réservons le droit de modifier cette politique. Les changements seront communiqués via les mises à jour de l\'application.\n\n8. Contact\nPour toute question relative à la confidentialité, contactez-nous via l\'App Store.';
}
