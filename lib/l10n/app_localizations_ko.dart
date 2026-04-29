// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Working Time';

  @override
  String get tabHome => '홈';

  @override
  String get tabWeek => '주간';

  @override
  String get tabHistory => '기록';

  @override
  String get onboardingSubtitle => '주간 근무 시간을\n설정하세요.';

  @override
  String get onboardingPerWeek => '주당';

  @override
  String get onboardingStart => '시작하기';

  @override
  String get homeStatusPaused => '휴식 중';

  @override
  String get homeStatusActive => '근무 중';

  @override
  String get homeStatusWeekly => '주간';

  @override
  String homePauseContext(String pauseDuration, String arrival) {
    return '휴식 $pauseDuration  •  $arrival부터';
  }

  @override
  String homeArrivalSince(String arrival) {
    return '$arrival부터';
  }

  @override
  String homeObjective(String target) {
    return '목표 $target';
  }

  @override
  String get homeReadyToClockIn => '출근 준비 완료';

  @override
  String get homeModeDaily => '일별';

  @override
  String get homeModeWeekly => '주별';

  @override
  String get homeResume => '근무 재개';

  @override
  String get homePause => '휴식';

  @override
  String get homeClockOut => '퇴근 기록';

  @override
  String get homeClockIn => '출근 기록';

  @override
  String get homeExpectedDeparture => '예상 퇴근';

  @override
  String get homeWeekLabel => '주간';

  @override
  String get homeClockOutTitle => '퇴근 기록';

  @override
  String get homeClockOutConfirm => '퇴근 시간을 기록하시겠습니까?';

  @override
  String get cancel => '취소';

  @override
  String get confirm => '확인';

  @override
  String get weeklyTitle => '이번\n주';

  @override
  String get weeklyObjectiveLabel => '목표';

  @override
  String get weeklyWorked => '근무';

  @override
  String get weeklyObjective => '목표';

  @override
  String get weeklyOvertime => '초과근무';

  @override
  String get weeklyRemaining => '남은 시간';

  @override
  String get weeklyDays => '요일별';

  @override
  String get weeklySettings => '설정';

  @override
  String get weeklyObjectiveMode => '목표 모드';

  @override
  String get weeklyDailyProgressDesc => '오늘의 진행 상황';

  @override
  String get weeklyWeekProgressDesc => '주간 전체 진행 상황';

  @override
  String get weeklyModeDay => '일별';

  @override
  String get weeklyModeWeek => '주별';

  @override
  String get weeklyToday => '오늘';

  @override
  String get weeklyDailySchedule => '일별 일정';

  @override
  String get weeklyCustomized => '맞춤';

  @override
  String get weeklyWeekTotal => '주간 합계';

  @override
  String get reset => '초기화';

  @override
  String get weeklyLunchBreak => '점심 휴식';

  @override
  String get weeklyLunchBreakHint => '퇴근 시간에 추가되는 휴식 시간';

  @override
  String get none => '없음';

  @override
  String get weeklyTargetEdit => '주간 목표 수정';

  @override
  String get weeklyCurrentTarget => '현재 목표';

  @override
  String get save => '저장';

  @override
  String get historyTitle => '근무 기록';

  @override
  String get historyEmpty => '기록 없음';

  @override
  String get historyEmptySubtitle => '근무일이\n여기에 표시됩니다.';

  @override
  String historyPauses(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count회 휴식',
      one: '1회 휴식',
    );
    return '$_temp0';
  }

  @override
  String get dayMon => '월요일';

  @override
  String get dayTue => '화요일';

  @override
  String get dayWed => '수요일';

  @override
  String get dayThu => '목요일';

  @override
  String get dayFri => '금요일';

  @override
  String get daySat => '토요일';

  @override
  String get daySun => '일요일';

  @override
  String get legalTitle => '법적 정보';

  @override
  String get termsTitle => '이용약관';

  @override
  String get privacyTitle => '개인정보 처리방침';

  @override
  String get legalLinkText => '이용약관 및 개인정보 처리방침';

  @override
  String get termsContent =>
      '이용약관\n\n최종 업데이트: 2026년 4월 29일\n\n1. 동의\nWorking Time을 사용함으로써 이 이용약관에 동의하는 것으로 간주됩니다.\n\n2. 서비스 설명\nWorking Time은 근무 시간을 추적하는 모바일 앱입니다.\n\n3. 개인 사용\n앱은 개인적인 비상업적 사용만을 위한 것입니다.\n\n4. 로컬 데이터\n모든 데이터는 기기에만 저장됩니다. 원격 서버에서 데이터를 수집하지 않습니다.\n\n5. 책임 제한\nWorking Time은 현재 상태로 제공됩니다. 법적 목적의 계산 정확성을 보장하지 않습니다.\n\n6. 변경\n언제든지 이 약관을 수정할 권리를 보유합니다.\n\n7. 문의\n질문이 있으시면 App Store를 통해 문의하세요.';

  @override
  String get privacyContent =>
      '개인정보 처리방침\n\n최종 업데이트: 2026년 4월 29일\n\n1. 수집 데이터\nWorking Time은 개인 데이터를 수집하지 않습니다. 모든 정보는 기기에 로컬 저장됩니다.\n\n2. 데이터 공유\n제3자와 데이터를 공유하지 않습니다.\n\n3. 권한\n알림 전송을 위해 알림 접근 권한을 요청할 수 있습니다.\n\n4. 보안\n기기의 보안 메커니즘으로 데이터가 보호됩니다.\n\n5. 데이터 삭제\n앱을 제거하여 언제든지 모든 데이터를 삭제할 수 있습니다.\n\n6. 어린이\n이 앱은 13세 미만 어린이를 위한 것이 아닙니다.\n\n7. 문의\n개인정보 관련 질문은 App Store를 통해 문의하세요.';
}
