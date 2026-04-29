// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Working Time';

  @override
  String get tabHome => 'Inicio';

  @override
  String get tabWeek => 'Semana';

  @override
  String get tabHistory => 'Historial';

  @override
  String get onboardingSubtitle => 'Configura tu horario\nde trabajo semanal.';

  @override
  String get onboardingPerWeek => 'POR SEMANA';

  @override
  String get onboardingStart => 'Comenzar';

  @override
  String get homeStatusPaused => 'EN PAUSA';

  @override
  String get homeStatusActive => 'EN CURSO';

  @override
  String get homeStatusWeekly => 'SEMANA';

  @override
  String homePauseContext(String pauseDuration, String arrival) {
    return 'pausa $pauseDuration  •  desde $arrival';
  }

  @override
  String homeArrivalSince(String arrival) {
    return 'desde $arrival';
  }

  @override
  String homeObjective(String target) {
    return 'objetivo $target';
  }

  @override
  String get homeReadyToClockIn => 'Listo para fichar';

  @override
  String get homeModeDaily => 'Diario';

  @override
  String get homeModeWeekly => 'Semanal';

  @override
  String get homeResume => 'Reanudar trabajo';

  @override
  String get homePause => 'Tomar un descanso';

  @override
  String get homeClockOut => 'Fichar salida';

  @override
  String get homeClockIn => 'Fichar entrada';

  @override
  String get homeExpectedDeparture => 'SALIDA PREVISTA';

  @override
  String get homeWeekLabel => 'SEMANA';

  @override
  String get homeClockOutTitle => 'Fichar salida';

  @override
  String get homeClockOutConfirm =>
      '¿Estás seguro de que quieres registrar tu hora de salida?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get weeklyTitle => 'ESTA\nSEMANA';

  @override
  String get weeklyObjectiveLabel => 'objetivo';

  @override
  String get weeklyWorked => 'Trabajado';

  @override
  String get weeklyObjective => 'Objetivo';

  @override
  String get weeklyOvertime => 'Horas extra';

  @override
  String get weeklyRemaining => 'Restante';

  @override
  String get weeklyDays => 'Días';

  @override
  String get weeklySettings => 'AJUSTES';

  @override
  String get weeklyObjectiveMode => 'Modo de objetivo';

  @override
  String get weeklyDailyProgressDesc => 'Progreso del día en curso';

  @override
  String get weeklyWeekProgressDesc => 'Progreso de la semana entera';

  @override
  String get weeklyModeDay => 'Día';

  @override
  String get weeklyModeWeek => 'Semana';

  @override
  String get weeklyToday => 'Hoy';

  @override
  String get weeklyDailySchedule => 'Horario por día';

  @override
  String get weeklyCustomized => 'Personalizado';

  @override
  String get weeklyWeekTotal => 'Total semanal';

  @override
  String get reset => 'Restablecer';

  @override
  String get weeklyLunchBreak => 'Pausa para almorzar';

  @override
  String get weeklyLunchBreakHint =>
      'Duración de pausa añadida a tu hora de salida';

  @override
  String get none => 'Ninguna';

  @override
  String get weeklyTargetEdit => 'Modificar objetivo semanal';

  @override
  String get weeklyCurrentTarget => 'Objetivo actual';

  @override
  String get save => 'Guardar';

  @override
  String get historyTitle => 'HISTORIAL';

  @override
  String get historyEmpty => 'Sin historial';

  @override
  String get historyEmptySubtitle => 'Tus días de trabajo\naparecerán aquí.';

  @override
  String historyPauses(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pausas',
      one: '1 pausa',
    );
    return '$_temp0';
  }

  @override
  String get dayMon => 'Lunes';

  @override
  String get dayTue => 'Martes';

  @override
  String get dayWed => 'Miércoles';

  @override
  String get dayThu => 'Jueves';

  @override
  String get dayFri => 'Viernes';

  @override
  String get daySat => 'Sábado';

  @override
  String get daySun => 'Domingo';

  @override
  String get legalTitle => 'Legal';

  @override
  String get termsTitle => 'Términos de uso';

  @override
  String get privacyTitle => 'Política de privacidad';

  @override
  String get legalLinkText => 'Términos de uso y Política de privacidad';

  @override
  String get termsContent =>
      'Términos de uso\n\nÚltima actualización: 29 de abril de 2026\n\n1. Aceptación\nAl usar Working Time, aceptas estos términos de uso. Si no estás de acuerdo, por favor no uses la aplicación.\n\n2. Descripción del servicio\nWorking Time es una aplicación móvil para el seguimiento del tiempo de trabajo.\n\n3. Uso personal\nLa aplicación es solo para uso personal y no comercial.\n\n4. Datos locales\nTodos tus datos se almacenan únicamente en tu dispositivo. No recopilamos datos en servidores remotos.\n\n5. Limitación de responsabilidad\nWorking Time se proporciona «tal cual». No garantizamos la exactitud de los cálculos para fines legales o contractuales.\n\n6. Cambios\nNos reservamos el derecho de modificar estos términos en cualquier momento.\n\n7. Contacto\nPara preguntas, contáctanos a través de la App Store.';

  @override
  String get privacyContent =>
      'Política de privacidad\n\nÚltima actualización: 29 de abril de 2026\n\n1. Datos recopilados\nWorking Time no recopila ningún dato personal. Toda la información se almacena localmente en tu dispositivo.\n\n2. Compartir datos\nNo se comparten datos con terceros.\n\n3. Permisos\nLa aplicación puede solicitar acceso a las notificaciones para enviarte recordatorios.\n\n4. Seguridad\nTus datos están protegidos por los mecanismos de seguridad de tu dispositivo.\n\n5. Eliminación de datos\nPuedes eliminar todos tus datos en cualquier momento desinstalando la aplicación.\n\n6. Menores\nEsta aplicación no está destinada a menores de 13 años.\n\n7. Contacto\nPara preguntas sobre privacidad, contáctanos a través de la App Store.';
}
