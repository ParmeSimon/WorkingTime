// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Working Time';

  @override
  String get tabHome => 'Главная';

  @override
  String get tabWeek => 'Неделя';

  @override
  String get tabHistory => 'История';

  @override
  String get onboardingSubtitle =>
      'Настройте свой\nеженедельный рабочий график.';

  @override
  String get onboardingPerWeek => 'В НЕДЕЛЮ';

  @override
  String get onboardingStart => 'Начать';

  @override
  String get homeStatusPaused => 'НА ПАУЗЕ';

  @override
  String get homeStatusActive => 'В РАБОТЕ';

  @override
  String get homeStatusWeekly => 'НЕДЕЛЯ';

  @override
  String homePauseContext(String pauseDuration, String arrival) {
    return 'перерыв $pauseDuration  •  с $arrival';
  }

  @override
  String homeArrivalSince(String arrival) {
    return 'с $arrival';
  }

  @override
  String homeObjective(String target) {
    return 'цель $target';
  }

  @override
  String get homeReadyToClockIn => 'Готов отметить приход';

  @override
  String get homeModeDaily => 'Ежедневно';

  @override
  String get homeModeWeekly => 'Еженедельно';

  @override
  String get homeResume => 'Продолжить работу';

  @override
  String get homePause => 'Сделать перерыв';

  @override
  String get homeClockOut => 'Отметить уход';

  @override
  String get homeClockIn => 'Отметить приход';

  @override
  String get homeExpectedDeparture => 'ОЖ. УХОД';

  @override
  String get homeWeekLabel => 'НЕДЕЛЯ';

  @override
  String get homeClockOutTitle => 'Отметить уход';

  @override
  String get homeClockOutConfirm =>
      'Вы уверены, что хотите записать время ухода?';

  @override
  String get cancel => 'Отмена';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get weeklyTitle => 'ЭТА\nНЕДЕЛЯ';

  @override
  String get weeklyObjectiveLabel => 'цель';

  @override
  String get weeklyWorked => 'Отработано';

  @override
  String get weeklyObjective => 'Цель';

  @override
  String get weeklyOvertime => 'Сверхурочные';

  @override
  String get weeklyRemaining => 'Осталось';

  @override
  String get weeklyDays => 'Дни';

  @override
  String get weeklySettings => 'НАСТРОЙКИ';

  @override
  String get weeklyObjectiveMode => 'Режим цели';

  @override
  String get weeklyDailyProgressDesc => 'Прогресс текущего дня';

  @override
  String get weeklyWeekProgressDesc => 'Прогресс за всю неделю';

  @override
  String get weeklyModeDay => 'День';

  @override
  String get weeklyModeWeek => 'Неделя';

  @override
  String get weeklyToday => 'Сег.';

  @override
  String get weeklyDailySchedule => 'Расписание по дням';

  @override
  String get weeklyCustomized => 'Настроено';

  @override
  String get weeklyWeekTotal => 'Итого за неделю';

  @override
  String get reset => 'Сбросить';

  @override
  String get weeklyLunchBreak => 'Обеденный перерыв';

  @override
  String get weeklyLunchBreakHint =>
      'Длительность перерыва добавляется к времени ухода';

  @override
  String get none => 'Нет';

  @override
  String get weeklyTargetEdit => 'Изменить еженедельную цель';

  @override
  String get weeklyCurrentTarget => 'Текущая цель';

  @override
  String get save => 'Сохранить';

  @override
  String get historyTitle => 'ИСТОРИЯ';

  @override
  String get historyEmpty => 'Нет истории';

  @override
  String get historyEmptySubtitle => 'Ваши рабочие дни\nпоявятся здесь.';

  @override
  String historyPauses(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count перерыва',
      many: '$count перерывов',
      few: '$count перерыва',
      one: '1 перерыв',
    );
    return '$_temp0';
  }

  @override
  String get dayMon => 'Понедельник';

  @override
  String get dayTue => 'Вторник';

  @override
  String get dayWed => 'Среда';

  @override
  String get dayThu => 'Четверг';

  @override
  String get dayFri => 'Пятница';

  @override
  String get daySat => 'Суббота';

  @override
  String get daySun => 'Воскресенье';

  @override
  String get legalTitle => 'Правовая информация';

  @override
  String get termsTitle => 'Условия использования';

  @override
  String get privacyTitle => 'Политика конфиденциальности';

  @override
  String get legalLinkText =>
      'Условия использования и Политика конфиденциальности';

  @override
  String get termsContent =>
      'Условия использования\n\nПоследнее обновление: 29 апреля 2026 г.\n\n1. Принятие условий\nИспользуя Working Time, вы принимаете настоящие условия использования.\n\n2. Описание сервиса\nWorking Time — мобильное приложение для отслеживания рабочего времени.\n\n3. Личное использование\nПриложение предназначено только для личного некоммерческого использования.\n\n4. Локальные данные\nВсе ваши данные хранятся только на вашем устройстве. Мы не собираем данные на удалённых серверах.\n\n5. Ограничение ответственности\nWorking Time предоставляется «как есть». Мы не гарантируем точность расчётов в юридических целях.\n\n6. Изменения\nМы оставляем за собой право изменять эти условия в любое время.\n\n7. Контакты\nПо вопросам обращайтесь через App Store.';

  @override
  String get privacyContent =>
      'Политика конфиденциальности\n\nПоследнее обновление: 29 апреля 2026 г.\n\n1. Собираемые данные\nWorking Time не собирает личные данные. Все данные хранятся локально на вашем устройстве.\n\n2. Передача данных\nДанные не передаются третьим лицам.\n\n3. Разрешения\nПриложение может запрашивать доступ к уведомлениям для напоминаний.\n\n4. Безопасность\nВаши данные защищены механизмами безопасности вашего устройства.\n\n5. Удаление данных\nВы можете удалить все данные в любой момент, удалив приложение.\n\n6. Дети\nЭто приложение не предназначено для детей до 13 лет.\n\n7. Контакты\nПо вопросам конфиденциальности обращайтесь через App Store.';
}
