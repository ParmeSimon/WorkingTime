import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../models/work_session.dart';
import '../services/notification_service.dart';

class WorkStore extends ChangeNotifier {
  List<WorkSession> _sessions = [];
  double _weeklyTargetHours = 35.0;
  bool _hasCompletedOnboarding = false;

  /// Planned lunch break in minutes, added to expected departure automatically.
  int _lunchBreakMinutes = 0;

  /// Custom hours per weekday (1=Mon … 7=Sun). Empty = use weeklyTargetHours/5.
  Map<int, double> _customDailyHours = {};

  /// true = ring shows today's progress,  false = ring shows week progress.
  bool _isDailyMode = true;

  static const _sessionsKey = 'wt_sessions';
  static const _targetKey = 'wt_target';
  static const _onboardingKey = 'wt_onboarding';
  static const _lunchKey = 'wt_lunch_minutes';
  static const _dailyHoursKey = 'wt_daily_hours';
  static const _dailyModeKey = 'wt_daily_mode';

  // ── Getters ───────────────────────────────────────────────────────────────

  List<WorkSession> get sessions => List.unmodifiable(_sessions);
  double get weeklyTargetHours => _weeklyTargetHours;
  bool get hasCompletedOnboarding => _hasCompletedOnboarding;
  int get lunchBreakMinutes => _lunchBreakMinutes;
  Map<int, double> get customDailyHours => Map.unmodifiable(_customDailyHours);
  bool get isDailyMode => _isDailyMode;

  WorkSession? get activeSession =>
      _sessions.where((s) => s.isActive).firstOrNull;

  bool get isClockedIn => activeSession != null;
  bool get isPaused => activeSession?.isPaused ?? false;

  /// Target hours for a specific day. Uses custom schedule if set.
  double dailyTargetForDay(DateTime day) =>
      _customDailyHours[day.weekday] ?? (_weeklyTargetHours / 5.0);

  /// Weekly target = sum of Mon–Fri custom hours, or plain weeklyTargetHours.
  double get effectiveWeeklyTarget {
    if (_customDailyHours.isEmpty) return _weeklyTargetHours;
    double total = 0;
    for (int d = 1; d <= 5; d++) {
      total += _customDailyHours[d] ?? (_weeklyTargetHours / 5.0);
    }
    return total;
  }

  // ── Clock In ──────────────────────────────────────────────────────────────

  void clockIn() {
    if (isClockedIn) return;
    _sessions.add(WorkSession(
      id: const Uuid().v4(),
      arrivalTime: DateTime.now(),
      weeklyTargetHours: _weeklyTargetHours,
    ));
    _save();
    _scheduleReminder();
    notifyListeners();
  }

  // ── Clock Out ─────────────────────────────────────────────────────────────

  void clockOut() {
    final idx = _sessions.indexWhere((s) => s.isActive);
    if (idx == -1) return;
    final now = DateTime.now();
    var session = _sessions[idx];
    if (session.isPaused) {
      session = session.copyWith(
        pauses: session.pauses
            .map((p) => p.isActive ? p.copyWith(end: now) : p)
            .toList(),
      );
    }
    _sessions[idx] = session.copyWith(departureTime: now);
    _save();
    NotificationService.cancel();
    notifyListeners();
  }

  // ── Pause / Resume ────────────────────────────────────────────────────────

  void startPause() {
    final idx = _sessions.indexWhere((s) => s.isActive);
    if (idx == -1) return;
    final session = _sessions[idx];
    if (session.isPaused) return;
    _sessions[idx] = session.copyWith(
      pauses: [...session.pauses, WorkPause(start: DateTime.now())],
    );
    _save();
    notifyListeners();
  }

  void endPause() {
    final idx = _sessions.indexWhere((s) => s.isActive);
    if (idx == -1) return;
    final session = _sessions[idx];
    if (!session.isPaused) return;
    final now = DateTime.now();
    _sessions[idx] = session.copyWith(
      pauses: session.pauses
          .map((p) => p.isActive ? p.copyWith(end: now) : p)
          .toList(),
    );
    _save();
    _scheduleReminder();
    notifyListeners();
  }

  // ── Settings ──────────────────────────────────────────────────────────────

  Future<void> setLunchBreakMinutes(int minutes) async {
    _lunchBreakMinutes = minutes;
    _save();
    if (isClockedIn) _scheduleReminder();
    notifyListeners();
  }

  Future<void> setWeeklyTarget(double hours) async {
    _weeklyTargetHours = hours;
    _hasCompletedOnboarding = true;
    _save();
    if (isClockedIn) _scheduleReminder();
    notifyListeners();
  }

  void setCustomDailyHours(Map<int, double> schedule) {
    _customDailyHours = Map.from(schedule);
    _save();
    if (isClockedIn) _scheduleReminder();
    notifyListeners();
  }

  void setObjectiveMode({required bool isDailyMode}) {
    _isDailyMode = isDailyMode;
    _save();
    notifyListeners();
  }

  // ── Expected departure ────────────────────────────────────────────────────

  DateTime? expectedDeparture(WorkSession session) {
    final dailyHours = dailyTargetForDay(session.arrivalTime);
    final dailySeconds = dailyHours * 3600;
    final now = DateTime.now();
    final trackedPauses = session.totalPauseDurationAt(now);
    return session.arrivalTime.add(
      Duration(seconds: dailySeconds.round()) +
          Duration(minutes: _lunchBreakMinutes) +
          trackedPauses,
    );
  }

  // ── Weekly aggregation ────────────────────────────────────────────────────

  List<WorkSession> sessionsForWeek(DateTime week) {
    final start = _weekStart(week);
    final end = start.add(const Duration(days: 7));
    return _sessions
        .where((s) =>
            !s.isActive &&
            s.arrivalTime
                .isAfter(start.subtract(const Duration(seconds: 1))) &&
            s.arrivalTime.isBefore(end))
        .toList();
  }

  Duration totalWorkedForWeek(DateTime week) {
    return sessionsForWeek(week)
        .map((s) => s.duration ?? Duration.zero)
        .fold(Duration.zero, (a, b) => a + b);
  }

  double progressForWeek(DateTime week) {
    final worked = totalWorkedForWeek(week).inSeconds;
    final target = effectiveWeeklyTarget * 3600;
    if (target == 0) return 0;
    return (worked / target).clamp(0.0, 1.0);
  }

  // ── Current week (live — includes ongoing session) ────────────────────────

  Duration get currentWeekTotal {
    final complete = sessionsForWeek(DateTime.now())
        .map((s) => s.duration ?? Duration.zero)
        .fold(Duration.zero, (a, b) => a + b);
    if (activeSession != null) {
      final now = DateTime.now();
      final elapsed = now.difference(activeSession!.arrivalTime);
      final ongoing = elapsed - activeSession!.totalPauseDurationAt(now);
      return complete + ongoing;
    }
    return complete;
  }

  double get currentWeekProgress {
    final target = effectiveWeeklyTarget * 3600;
    if (target == 0) return 0;
    return (currentWeekTotal.inSeconds / target).clamp(0.0, 1.0);
  }

  // ── Today's live progress (for daily-objective mode) ──────────────────────

  Duration get todayWorked {
    final now = DateTime.now();
    // Completed sessions today
    final done = _sessions
        .where((s) =>
            !s.isActive &&
            s.arrivalTime.year == now.year &&
            s.arrivalTime.month == now.month &&
            s.arrivalTime.day == now.day)
        .map((s) => s.duration ?? Duration.zero)
        .fold(Duration.zero, (a, b) => a + b);
    if (activeSession != null) {
      final elapsed = now.difference(activeSession!.arrivalTime);
      final net = elapsed - activeSession!.totalPauseDurationAt(now);
      return done + net;
    }
    return done;
  }

  double get todayProgress {
    final target = dailyTargetForDay(DateTime.now()) * 3600;
    if (target == 0) return 0;
    return (todayWorked.inSeconds / target).clamp(0.0, 1.0);
  }

  // ── Weeks with data ───────────────────────────────────────────────────────

  List<DateTime> get weeksWithData {
    final complete = _sessions.where((s) => !s.isActive).toList();
    final keys = <String, DateTime>{};
    for (final s in complete) {
      final ws = _weekStart(s.arrivalTime);
      keys[ws.toIso8601String()] = ws;
    }
    final list = keys.values.toList()..sort((a, b) => b.compareTo(a));
    return list;
  }

  // ── Delete session ────────────────────────────────────────────────────────

  void deleteSession(String id) {
    _sessions.removeWhere((s) => s.id == id);
    _save();
    notifyListeners();
  }

  // ── Persistence ───────────────────────────────────────────────────────────

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _weeklyTargetHours = prefs.getDouble(_targetKey) ?? 35.0;
    _hasCompletedOnboarding = prefs.getBool(_onboardingKey) ?? false;
    _lunchBreakMinutes = prefs.getInt(_lunchKey) ?? 0;
    _isDailyMode = prefs.getBool(_dailyModeKey) ?? true;

    final rawHours = prefs.getString(_dailyHoursKey);
    if (rawHours != null) {
      try {
        final decoded = jsonDecode(rawHours) as Map<String, dynamic>;
        _customDailyHours =
            decoded.map((k, v) => MapEntry(int.parse(k), (v as num).toDouble()));
      } catch (_) {
        _customDailyHours = {};
      }
    }

    final raw = prefs.getString(_sessionsKey);
    if (raw != null) {
      try {
        _sessions = sessionsFromJsonString(raw);
      } catch (_) {
        _sessions = [];
      }
    }
    notifyListeners();
  }

  void _save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_sessionsKey, sessionsToJsonString(_sessions));
    prefs.setDouble(_targetKey, _weeklyTargetHours);
    prefs.setBool(_onboardingKey, _hasCompletedOnboarding);
    prefs.setInt(_lunchKey, _lunchBreakMinutes);
    prefs.setBool(_dailyModeKey, _isDailyMode);
    prefs.setString(
      _dailyHoursKey,
      jsonEncode(_customDailyHours.map((k, v) => MapEntry(k.toString(), v))),
    );
  }

  // ── Notification helper ───────────────────────────────────────────────────

  void _scheduleReminder() {
    final active = activeSession;
    if (active == null) return;
    final dep = expectedDeparture(active);
    if (dep == null) return;
    NotificationService.scheduleEndOfDayReminder(dep);
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  DateTime _weekStart(DateTime d) {
    final daysFromMonday = (d.weekday - 1) % 7;
    final monday = DateTime(d.year, d.month, d.day)
        .subtract(Duration(days: daysFromMonday));
    return monday;
  }
}
