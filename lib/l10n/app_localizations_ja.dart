// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Working Time';

  @override
  String get tabHome => 'ホーム';

  @override
  String get tabWeek => '週間';

  @override
  String get tabHistory => '履歴';

  @override
  String get onboardingSubtitle => '週間労働時間を\n設定してください。';

  @override
  String get onboardingPerWeek => '週あたり';

  @override
  String get onboardingStart => '始める';

  @override
  String get homeStatusPaused => '休憩中';

  @override
  String get homeStatusActive => '作業中';

  @override
  String get homeStatusWeekly => '週間';

  @override
  String homePauseContext(String pauseDuration, String arrival) {
    return '休憩 $pauseDuration  •  $arrivalから';
  }

  @override
  String homeArrivalSince(String arrival) {
    return '$arrivalから';
  }

  @override
  String homeObjective(String target) {
    return '目標 $target';
  }

  @override
  String get homeReadyToClockIn => '打刻する準備完了';

  @override
  String get homeModeDaily => '日次';

  @override
  String get homeModeWeekly => '週次';

  @override
  String get homeResume => '作業再開';

  @override
  String get homePause => '休憩する';

  @override
  String get homeClockOut => '退勤打刻';

  @override
  String get homeClockIn => '出勤打刻';

  @override
  String get homeExpectedDeparture => '退勤予定';

  @override
  String get homeWeekLabel => '週間';

  @override
  String get homeClockOutTitle => '退勤打刻';

  @override
  String get homeClockOutConfirm => '退勤時刻を記録してもよいですか？';

  @override
  String get cancel => 'キャンセル';

  @override
  String get confirm => '確認';

  @override
  String get weeklyTitle => '今週の\n概要';

  @override
  String get weeklyObjectiveLabel => '目標';

  @override
  String get weeklyWorked => '勤務時間';

  @override
  String get weeklyObjective => '目標';

  @override
  String get weeklyOvertime => '残業';

  @override
  String get weeklyRemaining => '残り';

  @override
  String get weeklyDays => '日別';

  @override
  String get weeklySettings => '設定';

  @override
  String get weeklyObjectiveMode => '目標モード';

  @override
  String get weeklyDailyProgressDesc => '当日の進捗';

  @override
  String get weeklyWeekProgressDesc => '週全体の進捗';

  @override
  String get weeklyModeDay => '日次';

  @override
  String get weeklyModeWeek => '週次';

  @override
  String get weeklyToday => '今日';

  @override
  String get weeklyDailySchedule => '日別スケジュール';

  @override
  String get weeklyCustomized => 'カスタム';

  @override
  String get weeklyWeekTotal => '週合計';

  @override
  String get reset => 'リセット';

  @override
  String get weeklyLunchBreak => '昼休憩';

  @override
  String get weeklyLunchBreakHint => '退勤時刻に加算される休憩時間';

  @override
  String get none => 'なし';

  @override
  String get weeklyTargetEdit => '週間目標を変更';

  @override
  String get weeklyCurrentTarget => '現在の目標';

  @override
  String get save => '保存';

  @override
  String get historyTitle => '履歴';

  @override
  String get historyEmpty => '履歴なし';

  @override
  String get historyEmptySubtitle => '勤務日が\nここに表示されます。';

  @override
  String historyPauses(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count回の休憩',
      one: '1回の休憩',
    );
    return '$_temp0';
  }

  @override
  String get dayMon => '月曜';

  @override
  String get dayTue => '火曜';

  @override
  String get dayWed => '水曜';

  @override
  String get dayThu => '木曜';

  @override
  String get dayFri => '金曜';

  @override
  String get daySat => '土曜';

  @override
  String get daySun => '日曜';

  @override
  String get legalTitle => '法的情報';

  @override
  String get termsTitle => '利用規約';

  @override
  String get privacyTitle => 'プライバシーポリシー';

  @override
  String get legalLinkText => '利用規約とプライバシーポリシー';

  @override
  String get termsContent =>
      '利用規約\n\n最終更新日：2026年4月29日\n\n1. 同意\nWorking Timeを使用することで、本利用規約に同意したことになります。\n\n2. サービスの説明\nWorking Timeは勤務時間を追跡するモバイルアプリです。\n\n3. 個人利用\nアプリは個人的な非商業的使用のみを目的としています。\n\n4. ローカルデータ\nすべてのデータはデバイスにのみ保存されます。リモートサーバーではデータを収集しません。\n\n5. 免責事項\nWorking Timeは「現状のまま」提供されます。法的目的での計算の正確性は保証しません。\n\n6. 変更\n条件はいつでも変更する権利を留保します。\n\n7. お問い合わせ\nご不明な点はApp Storeからお問い合わせください。';

  @override
  String get privacyContent =>
      'プライバシーポリシー\n\n最終更新日：2026年4月29日\n\n1. 収集するデータ\nWorking Timeは個人データを収集しません。すべての情報はデバイスにローカル保存されます。\n\n2. データの共有\nデータは第三者と共有されません。\n\n3. 権限\nアプリはリマインダー送信のため通知アクセスを要求する場合があります。\n\n4. セキュリティ\nデータはデバイスのセキュリティ機能で保護されます。\n\n5. データの削除\nアプリをアンインストールすることでデータを削除できます。\n\n6. 子供\nこのアプリは13歳未満の子供を対象としていません。\n\n7. お問い合わせ\nプライバシーに関するご質問はApp Storeからお問い合わせください。';
}
