// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Working Time';

  @override
  String get tabHome => 'Início';

  @override
  String get tabWeek => 'Semana';

  @override
  String get tabHistory => 'Histórico';

  @override
  String get onboardingSubtitle =>
      'Configure sua jornada\nde trabalho semanal.';

  @override
  String get onboardingPerWeek => 'POR SEMANA';

  @override
  String get onboardingStart => 'Começar';

  @override
  String get homeStatusPaused => 'EM PAUSA';

  @override
  String get homeStatusActive => 'EM ANDAMENTO';

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
    return 'meta $target';
  }

  @override
  String get homeReadyToClockIn => 'Pronto para registrar';

  @override
  String get homeModeDaily => 'Diário';

  @override
  String get homeModeWeekly => 'Semanal';

  @override
  String get homeResume => 'Retomar trabalho';

  @override
  String get homePause => 'Fazer pausa';

  @override
  String get homeClockOut => 'Registrar saída';

  @override
  String get homeClockIn => 'Registrar entrada';

  @override
  String get homeExpectedDeparture => 'SAÍDA PREVISTA';

  @override
  String get homeWeekLabel => 'SEMANA';

  @override
  String get homeClockOutTitle => 'Registrar saída';

  @override
  String get homeClockOutConfirm =>
      'Tem certeza que deseja registrar sua hora de saída?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get weeklyTitle => 'ESTA\nSEMANA';

  @override
  String get weeklyObjectiveLabel => 'meta';

  @override
  String get weeklyWorked => 'Trabalhado';

  @override
  String get weeklyObjective => 'Meta';

  @override
  String get weeklyOvertime => 'Horas extras';

  @override
  String get weeklyRemaining => 'Restante';

  @override
  String get weeklyDays => 'Dias';

  @override
  String get weeklySettings => 'CONFIGURAÇÕES';

  @override
  String get weeklyObjectiveMode => 'Modo de meta';

  @override
  String get weeklyDailyProgressDesc => 'Progresso do dia atual';

  @override
  String get weeklyWeekProgressDesc => 'Progresso da semana inteira';

  @override
  String get weeklyModeDay => 'Dia';

  @override
  String get weeklyModeWeek => 'Semana';

  @override
  String get weeklyToday => 'Hoje';

  @override
  String get weeklyDailySchedule => 'Horário por dia';

  @override
  String get weeklyCustomized => 'Personalizado';

  @override
  String get weeklyWeekTotal => 'Total semanal';

  @override
  String get reset => 'Redefinir';

  @override
  String get weeklyLunchBreak => 'Pausa para almoço';

  @override
  String get weeklyLunchBreakHint =>
      'Duração da pausa adicionada à sua hora de saída';

  @override
  String get none => 'Nenhuma';

  @override
  String get weeklyTargetEdit => 'Editar meta semanal';

  @override
  String get weeklyCurrentTarget => 'Meta atual';

  @override
  String get save => 'Salvar';

  @override
  String get historyTitle => 'HISTÓRICO';

  @override
  String get historyEmpty => 'Sem histórico';

  @override
  String get historyEmptySubtitle => 'Seus dias de trabalho\naparecerão aqui.';

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
  String get dayMon => 'Segunda';

  @override
  String get dayTue => 'Terça';

  @override
  String get dayWed => 'Quarta';

  @override
  String get dayThu => 'Quinta';

  @override
  String get dayFri => 'Sexta';

  @override
  String get daySat => 'Sábado';

  @override
  String get daySun => 'Domingo';

  @override
  String get legalTitle => 'Legal';

  @override
  String get termsTitle => 'Termos de uso';

  @override
  String get privacyTitle => 'Política de privacidade';

  @override
  String get legalLinkText => 'Termos de uso e Política de privacidade';

  @override
  String get termsContent =>
      'Termos de uso\n\nÚltima atualização: 29 de abril de 2026\n\n1. Aceitação\nAo usar o Working Time, você concorda com estes termos de uso.\n\n2. Descrição do serviço\nWorking Time é um aplicativo móvel de controle de tempo de trabalho.\n\n3. Uso pessoal\nO aplicativo é apenas para uso pessoal e não comercial.\n\n4. Dados locais\nTodos os seus dados são armazenados apenas no seu dispositivo. Não coletamos dados em servidores remotos.\n\n5. Limitação de responsabilidade\nWorking Time é fornecido \"como está\". Não garantimos a precisão dos cálculos para fins legais.\n\n6. Alterações\nReservamo-nos o direito de modificar estes termos a qualquer momento.\n\n7. Contato\nPara dúvidas, entre em contato conosco pela App Store.';

  @override
  String get privacyContent =>
      'Política de privacidade\n\nÚltima atualização: 29 de abril de 2026\n\n1. Dados coletados\nWorking Time não coleta dados pessoais. Todas as informações são armazenadas localmente no seu dispositivo.\n\n2. Compartilhamento de dados\nNenhum dado é compartilhado com terceiros.\n\n3. Permissões\nO aplicativo pode solicitar acesso a notificações para enviar lembretes.\n\n4. Segurança\nSeus dados são protegidos pelos mecanismos de segurança do seu dispositivo.\n\n5. Exclusão de dados\nVocê pode excluir todos os seus dados desinstalando o aplicativo.\n\n6. Crianças\nEste aplicativo não se destina a crianças menores de 13 anos.\n\n7. Contato\nPara dúvidas sobre privacidade, entre em contato pela App Store.';
}
