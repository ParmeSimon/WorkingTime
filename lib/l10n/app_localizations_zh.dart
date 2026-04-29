// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Working Time';

  @override
  String get tabHome => '首页';

  @override
  String get tabWeek => '本周';

  @override
  String get tabHistory => '记录';

  @override
  String get onboardingSubtitle => '设置您的每周\n工作时间。';

  @override
  String get onboardingPerWeek => '每周';

  @override
  String get onboardingStart => '开始';

  @override
  String get homeStatusPaused => '休息中';

  @override
  String get homeStatusActive => '工作中';

  @override
  String get homeStatusWeekly => '本周';

  @override
  String homePauseContext(String pauseDuration, String arrival) {
    return '休息 $pauseDuration  •  自 $arrival';
  }

  @override
  String homeArrivalSince(String arrival) {
    return '自 $arrival';
  }

  @override
  String homeObjective(String target) {
    return '目标 $target';
  }

  @override
  String get homeReadyToClockIn => '准备打卡';

  @override
  String get homeModeDaily => '每日';

  @override
  String get homeModeWeekly => '每周';

  @override
  String get homeResume => '继续工作';

  @override
  String get homePause => '休息';

  @override
  String get homeClockOut => '下班打卡';

  @override
  String get homeClockIn => '上班打卡';

  @override
  String get homeExpectedDeparture => '预计下班';

  @override
  String get homeWeekLabel => '本周';

  @override
  String get homeClockOutTitle => '下班打卡';

  @override
  String get homeClockOutConfirm => '确定要记录下班时间吗？';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确认';

  @override
  String get weeklyTitle => '本周\n概览';

  @override
  String get weeklyObjectiveLabel => '目标';

  @override
  String get weeklyWorked => '已工作';

  @override
  String get weeklyObjective => '目标';

  @override
  String get weeklyOvertime => '加班';

  @override
  String get weeklyRemaining => '剩余';

  @override
  String get weeklyDays => '工作日';

  @override
  String get weeklySettings => '设置';

  @override
  String get weeklyObjectiveMode => '目标模式';

  @override
  String get weeklyDailyProgressDesc => '当日进度';

  @override
  String get weeklyWeekProgressDesc => '全周进度';

  @override
  String get weeklyModeDay => '每日';

  @override
  String get weeklyModeWeek => '每周';

  @override
  String get weeklyToday => '今天';

  @override
  String get weeklyDailySchedule => '每日时间表';

  @override
  String get weeklyCustomized => '自定义';

  @override
  String get weeklyWeekTotal => '周合计';

  @override
  String get reset => '重置';

  @override
  String get weeklyLunchBreak => '午休';

  @override
  String get weeklyLunchBreakHint => '午休时长将计入下班时间';

  @override
  String get none => '无';

  @override
  String get weeklyTargetEdit => '修改每周目标';

  @override
  String get weeklyCurrentTarget => '当前目标';

  @override
  String get save => '保存';

  @override
  String get historyTitle => '工作记录';

  @override
  String get historyEmpty => '暂无记录';

  @override
  String get historyEmptySubtitle => '您的工作日记录\n将显示在这里。';

  @override
  String historyPauses(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count次休息',
      one: '1次休息',
    );
    return '$_temp0';
  }

  @override
  String get dayMon => '周一';

  @override
  String get dayTue => '周二';

  @override
  String get dayWed => '周三';

  @override
  String get dayThu => '周四';

  @override
  String get dayFri => '周五';

  @override
  String get daySat => '周六';

  @override
  String get daySun => '周日';

  @override
  String get legalTitle => '法律信息';

  @override
  String get termsTitle => '使用条款';

  @override
  String get privacyTitle => '隐私政策';

  @override
  String get legalLinkText => '使用条款和隐私政策';

  @override
  String get termsContent =>
      '使用条款\n\n最后更新：2026年4月29日\n\n1. 接受条款\n使用Working Time即表示您接受本使用条款。\n\n2. 服务说明\nWorking Time是一款用于跟踪工作时间的移动应用程序。\n\n3. 个人使用\n本应用程序仅供个人非商业使用。\n\n4. 本地数据\n您的所有数据仅存储在您的设备上。我们不在远程服务器上收集数据。\n\n5. 责任限制\nWorking Time按\"现状\"提供。我们不保证计算结果用于法律目的的准确性。\n\n6. 变更\n我们保留随时修改这些条款的权利。\n\n7. 联系方式\n如有疑问，请通过App Store联系我们。';

  @override
  String get privacyContent =>
      '隐私政策\n\n最后更新：2026年4月29日\n\n1. 收集的数据\nWorking Time不收集任何个人数据。所有信息均本地存储在您的设备上。\n\n2. 数据共享\n不会与第三方共享任何数据。\n\n3. 权限\n应用程序可能请求通知访问权限以发送提醒。\n\n4. 安全\n您的数据受设备安全机制保护。\n\n5. 数据删除\n您可以通过卸载应用程序随时删除所有数据。\n\n6. 儿童\n本应用程序不适合13岁以下儿童使用。\n\n7. 联系方式\n如有隐私相关问题，请通过App Store联系我们。';
}
