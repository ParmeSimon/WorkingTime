import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ru'),
    Locale('zh')
  ];

  /// App name
  ///
  /// In fr, this message translates to:
  /// **'Working Time'**
  String get appTitle;

  /// Bottom nav home tab
  ///
  /// In fr, this message translates to:
  /// **'Accueil'**
  String get tabHome;

  /// Bottom nav week tab
  ///
  /// In fr, this message translates to:
  /// **'Semaine'**
  String get tabWeek;

  /// Bottom nav history tab
  ///
  /// In fr, this message translates to:
  /// **'Historique'**
  String get tabHistory;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Configurez votre temps de\ntravail hebdomadaire.'**
  String get onboardingSubtitle;

  /// No description provided for @onboardingPerWeek.
  ///
  /// In fr, this message translates to:
  /// **'PAR SEMAINE'**
  String get onboardingPerWeek;

  /// No description provided for @onboardingStart.
  ///
  /// In fr, this message translates to:
  /// **'Commencer'**
  String get onboardingStart;

  /// No description provided for @homeStatusPaused.
  ///
  /// In fr, this message translates to:
  /// **'EN PAUSE'**
  String get homeStatusPaused;

  /// No description provided for @homeStatusActive.
  ///
  /// In fr, this message translates to:
  /// **'EN COURS'**
  String get homeStatusActive;

  /// No description provided for @homeStatusWeekly.
  ///
  /// In fr, this message translates to:
  /// **'SEMAINE'**
  String get homeStatusWeekly;

  /// No description provided for @homePauseContext.
  ///
  /// In fr, this message translates to:
  /// **'pause {pauseDuration}  •  depuis {arrival}'**
  String homePauseContext(String pauseDuration, String arrival);

  /// No description provided for @homeArrivalSince.
  ///
  /// In fr, this message translates to:
  /// **'depuis {arrival}'**
  String homeArrivalSince(String arrival);

  /// No description provided for @homeObjective.
  ///
  /// In fr, this message translates to:
  /// **'objectif {target}'**
  String homeObjective(String target);

  /// No description provided for @homeReadyToClockIn.
  ///
  /// In fr, this message translates to:
  /// **'Prêt à pointer'**
  String get homeReadyToClockIn;

  /// No description provided for @homeModeDaily.
  ///
  /// In fr, this message translates to:
  /// **'Journalier'**
  String get homeModeDaily;

  /// No description provided for @homeModeWeekly.
  ///
  /// In fr, this message translates to:
  /// **'Hebdomadaire'**
  String get homeModeWeekly;

  /// No description provided for @homeResume.
  ///
  /// In fr, this message translates to:
  /// **'Reprendre le travail'**
  String get homeResume;

  /// No description provided for @homePause.
  ///
  /// In fr, this message translates to:
  /// **'Mettre en pause'**
  String get homePause;

  /// No description provided for @homeClockOut.
  ///
  /// In fr, this message translates to:
  /// **'Pointer ma sortie'**
  String get homeClockOut;

  /// No description provided for @homeClockIn.
  ///
  /// In fr, this message translates to:
  /// **'Pointer mon arrivée'**
  String get homeClockIn;

  /// No description provided for @homeExpectedDeparture.
  ///
  /// In fr, this message translates to:
  /// **'DÉPART PRÉVU'**
  String get homeExpectedDeparture;

  /// No description provided for @homeWeekLabel.
  ///
  /// In fr, this message translates to:
  /// **'SEMAINE'**
  String get homeWeekLabel;

  /// No description provided for @homeClockOutTitle.
  ///
  /// In fr, this message translates to:
  /// **'Pointer la sortie'**
  String get homeClockOutTitle;

  /// No description provided for @homeClockOutConfirm.
  ///
  /// In fr, this message translates to:
  /// **'Êtes-vous sûr de vouloir enregistrer votre heure de sortie ?'**
  String get homeClockOutConfirm;

  /// No description provided for @cancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer'**
  String get confirm;

  /// No description provided for @weeklyTitle.
  ///
  /// In fr, this message translates to:
  /// **'CETTE\nSEMAINE'**
  String get weeklyTitle;

  /// No description provided for @weeklyObjectiveLabel.
  ///
  /// In fr, this message translates to:
  /// **'objectif'**
  String get weeklyObjectiveLabel;

  /// No description provided for @weeklyWorked.
  ///
  /// In fr, this message translates to:
  /// **'Travaillé'**
  String get weeklyWorked;

  /// No description provided for @weeklyObjective.
  ///
  /// In fr, this message translates to:
  /// **'Objectif'**
  String get weeklyObjective;

  /// No description provided for @weeklyOvertime.
  ///
  /// In fr, this message translates to:
  /// **'Heures sup.'**
  String get weeklyOvertime;

  /// No description provided for @weeklyRemaining.
  ///
  /// In fr, this message translates to:
  /// **'Restant'**
  String get weeklyRemaining;

  /// No description provided for @weeklyDays.
  ///
  /// In fr, this message translates to:
  /// **'Journées'**
  String get weeklyDays;

  /// No description provided for @weeklySettings.
  ///
  /// In fr, this message translates to:
  /// **'PARAMÈTRES'**
  String get weeklySettings;

  /// No description provided for @weeklyObjectiveMode.
  ///
  /// In fr, this message translates to:
  /// **'Mode d\'objectif'**
  String get weeklyObjectiveMode;

  /// No description provided for @weeklyDailyProgressDesc.
  ///
  /// In fr, this message translates to:
  /// **'Progression sur la journée en cours'**
  String get weeklyDailyProgressDesc;

  /// No description provided for @weeklyWeekProgressDesc.
  ///
  /// In fr, this message translates to:
  /// **'Progression sur la semaine entière'**
  String get weeklyWeekProgressDesc;

  /// No description provided for @weeklyModeDay.
  ///
  /// In fr, this message translates to:
  /// **'Jour'**
  String get weeklyModeDay;

  /// No description provided for @weeklyModeWeek.
  ///
  /// In fr, this message translates to:
  /// **'Semaine'**
  String get weeklyModeWeek;

  /// No description provided for @weeklyToday.
  ///
  /// In fr, this message translates to:
  /// **'Auj.'**
  String get weeklyToday;

  /// No description provided for @weeklyDailySchedule.
  ///
  /// In fr, this message translates to:
  /// **'Horaires par jour'**
  String get weeklyDailySchedule;

  /// No description provided for @weeklyCustomized.
  ///
  /// In fr, this message translates to:
  /// **'Personnalisé'**
  String get weeklyCustomized;

  /// No description provided for @weeklyWeekTotal.
  ///
  /// In fr, this message translates to:
  /// **'Total semaine'**
  String get weeklyWeekTotal;

  /// No description provided for @reset.
  ///
  /// In fr, this message translates to:
  /// **'Réinitialiser'**
  String get reset;

  /// No description provided for @weeklyLunchBreak.
  ///
  /// In fr, this message translates to:
  /// **'Pause déjeuner'**
  String get weeklyLunchBreak;

  /// No description provided for @weeklyLunchBreakHint.
  ///
  /// In fr, this message translates to:
  /// **'Durée de pause ajoutée à votre heure de départ'**
  String get weeklyLunchBreakHint;

  /// No description provided for @none.
  ///
  /// In fr, this message translates to:
  /// **'Aucune'**
  String get none;

  /// No description provided for @weeklyTargetEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier l\'objectif hebdomadaire'**
  String get weeklyTargetEdit;

  /// No description provided for @weeklyCurrentTarget.
  ///
  /// In fr, this message translates to:
  /// **'Objectif actuel'**
  String get weeklyCurrentTarget;

  /// No description provided for @save.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer'**
  String get save;

  /// No description provided for @historyTitle.
  ///
  /// In fr, this message translates to:
  /// **'HISTORIQUE'**
  String get historyTitle;

  /// No description provided for @historyEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Aucun historique'**
  String get historyEmpty;

  /// No description provided for @historyEmptySubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Vos journées de travail\napparaîtront ici.'**
  String get historyEmptySubtitle;

  /// No description provided for @historyPauses.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, one{1 pause} other{{count} pauses}}'**
  String historyPauses(int count);

  /// No description provided for @dayMon.
  ///
  /// In fr, this message translates to:
  /// **'Lundi'**
  String get dayMon;

  /// No description provided for @dayTue.
  ///
  /// In fr, this message translates to:
  /// **'Mardi'**
  String get dayTue;

  /// No description provided for @dayWed.
  ///
  /// In fr, this message translates to:
  /// **'Mercredi'**
  String get dayWed;

  /// No description provided for @dayThu.
  ///
  /// In fr, this message translates to:
  /// **'Jeudi'**
  String get dayThu;

  /// No description provided for @dayFri.
  ///
  /// In fr, this message translates to:
  /// **'Vendredi'**
  String get dayFri;

  /// No description provided for @daySat.
  ///
  /// In fr, this message translates to:
  /// **'Samedi'**
  String get daySat;

  /// No description provided for @daySun.
  ///
  /// In fr, this message translates to:
  /// **'Dimanche'**
  String get daySun;

  /// No description provided for @legalTitle.
  ///
  /// In fr, this message translates to:
  /// **'Légal'**
  String get legalTitle;

  /// No description provided for @termsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Conditions d\'utilisation'**
  String get termsTitle;

  /// No description provided for @privacyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Politique de confidentialité'**
  String get privacyTitle;

  /// No description provided for @legalLinkText.
  ///
  /// In fr, this message translates to:
  /// **'Conditions d\'utilisation & Politique de confidentialité'**
  String get legalLinkText;

  /// No description provided for @termsContent.
  ///
  /// In fr, this message translates to:
  /// **'Conditions d\'utilisation\n\nDernière mise à jour : 29 avril 2026\n\n1. Acceptation des conditions\nEn utilisant Working Time, vous acceptez les présentes conditions d\'utilisation. Si vous n\'acceptez pas ces conditions, veuillez ne pas utiliser l\'application.\n\n2. Description du service\nWorking Time est une application mobile de suivi du temps de travail. Elle vous permet d\'enregistrer vos heures d\'arrivée et de départ, vos pauses et de visualiser vos statistiques hebdomadaires.\n\n3. Utilisation personnelle\nL\'application est destinée à un usage personnel et non commercial. Vous vous engagez à ne pas utiliser l\'application à des fins illégales ou nuisibles.\n\n4. Données locales\nToutes vos données (sessions, paramètres) sont stockées uniquement sur votre appareil. Nous ne collectons aucune donnée sur des serveurs distants.\n\n5. Limitation de responsabilité\nWorking Time est fournie « en l\'état ». Nous ne garantissons pas l\'exactitude des calculs à des fins légales ou contractuelles. L\'application ne remplace pas un système officiel de pointage.\n\n6. Modifications\nNous nous réservons le droit de modifier ces conditions à tout moment. Les modifications seront notifiées via une mise à jour de l\'application.\n\n7. Contact\nPour toute question, contactez-nous via l\'App Store.'**
  String get termsContent;

  /// No description provided for @privacyContent.
  ///
  /// In fr, this message translates to:
  /// **'Politique de confidentialité\n\nDernière mise à jour : 29 avril 2026\n\n1. Données collectées\nWorking Time ne collecte aucune donnée personnelle. Toutes les informations (heures de travail, paramètres, historique) sont stockées localement sur votre appareil via le stockage sécurisé de votre système d\'exploitation.\n\n2. Partage des données\nAucune donnée n\'est partagée avec des tiers. Nous n\'avons accès à aucune de vos informations.\n\n3. Permissions\nL\'application peut demander l\'accès aux notifications pour vous envoyer des rappels de pointage. Ces notifications restent locales à votre appareil.\n\n4. Sécurité\nVos données sont protégées par les mécanismes de sécurité de votre appareil (chiffrement, accès biométrique, etc.).\n\n5. Suppression des données\nVous pouvez supprimer toutes vos données à tout moment depuis les paramètres de l\'application ou en désinstallant l\'application.\n\n6. Enfants\nCette application n\'est pas destinée aux enfants de moins de 13 ans.\n\n7. Modifications\nNous nous réservons le droit de modifier cette politique. Les changements seront communiqués via les mises à jour de l\'application.\n\n8. Contact\nPour toute question relative à la confidentialité, contactez-nous via l\'App Store.'**
  String get privacyContent;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'de',
        'en',
        'es',
        'fr',
        'it',
        'ja',
        'ko',
        'pt',
        'ru',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
