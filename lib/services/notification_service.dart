import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

class NotificationService {
  NotificationService._();

  static final _plugin = FlutterLocalNotificationsPlugin();

  static const _channelId = 'wt_eod';
  static const _channelName = 'Fin de journée';
  static const _notifId = 42;

  // ── Init ─────────────────────────────────────────────────────────────────

  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await _plugin.initialize(
      settings: const InitializationSettings(android: android, iOS: ios),
    );
  }

  static Future<void> requestPermissions() async {
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await _plugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  // ── Schedule ──────────────────────────────────────────────────────────────

  /// Schedules (or re-schedules) the "10 minutes to go" reminder.
  /// Cancels any previous reminder first.
  static Future<void> scheduleEndOfDayReminder(
      DateTime expectedDeparture) async {
    await _plugin.cancel(id: _notifId);

    final reminderTime =
        expectedDeparture.subtract(const Duration(minutes: 10));
    if (!reminderTime.isAfter(DateTime.now())) return;

    final scheduled = tz.TZDateTime.from(reminderTime, tz.local);
    final departureStr = DateFormat('HH:mm').format(expectedDeparture);

    await _plugin.zonedSchedule(
      id: _notifId,
      title: 'Fin de journée dans 10 min',
      body: 'Départ prévu à $departureStr',
      scheduledDate: scheduled,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription:
              'Rappel 10 minutes avant la fin de votre journée',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  // ── Cancel ────────────────────────────────────────────────────────────────

  static Future<void> cancel() async {
    await _plugin.cancel(id: _notifId);
  }
}
