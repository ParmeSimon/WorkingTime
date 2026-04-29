// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Working Time';

  @override
  String get tabHome => 'الرئيسية';

  @override
  String get tabWeek => 'الأسبوع';

  @override
  String get tabHistory => 'السجل';

  @override
  String get onboardingSubtitle => 'قم بإعداد ساعات\nعملك الأسبوعية.';

  @override
  String get onboardingPerWeek => 'في الأسبوع';

  @override
  String get onboardingStart => 'ابدأ';

  @override
  String get homeStatusPaused => 'في استراحة';

  @override
  String get homeStatusActive => 'جار العمل';

  @override
  String get homeStatusWeekly => 'الأسبوع';

  @override
  String homePauseContext(String pauseDuration, String arrival) {
    return 'استراحة $pauseDuration  -  منذ $arrival';
  }

  @override
  String homeArrivalSince(String arrival) {
    return 'منذ $arrival';
  }

  @override
  String homeObjective(String target) {
    return 'الهدف $target';
  }

  @override
  String get homeReadyToClockIn => 'جاهز لتسجيل الحضور';

  @override
  String get homeModeDaily => 'يومي';

  @override
  String get homeModeWeekly => 'أسبوعي';

  @override
  String get homeResume => 'استئناف العمل';

  @override
  String get homePause => 'أخذ استراحة';

  @override
  String get homeClockOut => 'تسجيل الانصراف';

  @override
  String get homeClockIn => 'تسجيل الحضور';

  @override
  String get homeExpectedDeparture => 'وقت المغادرة المتوقع';

  @override
  String get homeWeekLabel => 'الأسبوع';

  @override
  String get homeClockOutTitle => 'تسجيل الانصراف';

  @override
  String get homeClockOutConfirm => 'هل أنت متأكد من تسجيل وقت مغادرتك؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirm => 'تأكيد';

  @override
  String get weeklyTitle => 'هذا\nالأسبوع';

  @override
  String get weeklyObjectiveLabel => 'الهدف';

  @override
  String get weeklyWorked => 'المنجز';

  @override
  String get weeklyObjective => 'الهدف';

  @override
  String get weeklyOvertime => 'إضافي';

  @override
  String get weeklyRemaining => 'المتبقي';

  @override
  String get weeklyDays => 'الأيام';

  @override
  String get weeklySettings => 'الإعدادات';

  @override
  String get weeklyObjectiveMode => 'وضع الهدف';

  @override
  String get weeklyDailyProgressDesc => 'تقدم اليوم الحالي';

  @override
  String get weeklyWeekProgressDesc => 'تقدم الأسبوع بالكامل';

  @override
  String get weeklyModeDay => 'يوم';

  @override
  String get weeklyModeWeek => 'أسبوع';

  @override
  String get weeklyToday => 'اليوم';

  @override
  String get weeklyDailySchedule => 'جدول يومي';

  @override
  String get weeklyCustomized => 'مخصص';

  @override
  String get weeklyWeekTotal => 'مجموع الأسبوع';

  @override
  String get reset => 'إعادة تعيين';

  @override
  String get weeklyLunchBreak => 'استراحة الغداء';

  @override
  String get weeklyLunchBreakHint => 'مدة الاستراحة المضافة لوقت المغادرة';

  @override
  String get none => 'لا شيء';

  @override
  String get weeklyTargetEdit => 'تعديل الهدف الأسبوعي';

  @override
  String get weeklyCurrentTarget => 'الهدف الحالي';

  @override
  String get save => 'حفظ';

  @override
  String get historyTitle => 'السجل';

  @override
  String get historyEmpty => 'لا يوجد سجل';

  @override
  String get historyEmptySubtitle => 'ستظهر أيام عملك\nهنا.';

  @override
  String historyPauses(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count استراحة',
      many: '$count استراحة',
      few: '$count استراحات',
      two: 'استراحتان',
      one: 'استراحة واحدة',
    );
    return '$_temp0';
  }

  @override
  String get dayMon => 'الاثنين';

  @override
  String get dayTue => 'الثلاثاء';

  @override
  String get dayWed => 'الأربعاء';

  @override
  String get dayThu => 'الخميس';

  @override
  String get dayFri => 'الجمعة';

  @override
  String get daySat => 'السبت';

  @override
  String get daySun => 'الأحد';

  @override
  String get legalTitle => 'قانوني';

  @override
  String get termsTitle => 'شروط الاستخدام';

  @override
  String get privacyTitle => 'سياسة الخصوصية';

  @override
  String get legalLinkText => 'شروط الاستخدام وسياسة الخصوصية';

  @override
  String get termsContent =>
      'شروط الاستخدام\n\nآخر تحديث: 29 أبريل 2026\n\n1. القبول\nباستخدام Working Time، فإنك توافق على هذه الشروط.\n\n2. وصف الخدمة\nWorking Time هو تطبيق جوال لتتبع ساعات العمل.\n\n3. الاستخدام الشخصي\nالتطبيق مخصص للاستخدام الشخصي غير التجاري فقط.\n\n4. البيانات المحلية\nجميع بياناتك مخزنة على جهازك فقط. لا يتم جمع بيانات على خوادم بعيدة.\n\n5. تحديد المسؤولية\nيقدم Working Time كما هو. دقة الحسابات للأغراض القانونية غير مضمونة.\n\n6. التحديثات\nيحق لنا تعديل هذه الشروط في أي وقت عبر تحديثات التطبيق.\n\n7. التواصل\nللاستفسار، تواصل معنا عبر App Store.';

  @override
  String get privacyContent =>
      'سياسة الخصوصية\n\nآخر تحديث: 29 أبريل 2026\n\n1. البيانات المجمعة\nلا يجمع Working Time أي بيانات شخصية. جميع المعلومات مخزنة محلياً على جهازك.\n\n2. مشاركة البيانات\nلا تتم مشاركة أي بيانات مع أطراف ثالثة.\n\n3. الأذونات\nقد يطلب التطبيق الوصول إلى الإشعارات لإرسال تذكيرات.\n\n4. الأمان\nبياناتك محمية بآليات أمان جهازك.\n\n5. حذف البيانات\nيمكنك حذف جميع بياناتك في أي وقت عن طريق إلغاء تثبيت التطبيق.\n\n6. الفئة العمرية\nهذا التطبيق غير مخصص للأطفال دون سن 13 عاماً.\n\n7. التواصل\nللاستفسار عن الخصوصية، تواصل معنا عبر App Store.';
}
