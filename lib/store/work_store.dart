import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../models/work_session.dart';

class WorkStore extends ChangeNotifier {
  List<WorkSession> _sessions = [];
  double _weeklyTargetHours = 35.0;
  bool _hasCompletedOnboarding = false;

  static const _sessionsKey = 'wt_sessions';
  static const _targetKey = 'wt_target';
  static const _onboardingKey = 'wt_onboarding';

  List<WorkSession> get sessions => List.unmodifiable(_sessions);
  double get weeklyTargetHours => _weeklyTargetHours;
  bool get hasCompletedOnboarding => _hasCompletedOnboarding;

  WorkSession? get activeSession =>
      _sessions.where((s) => s.isActive).firstOrNull;

  bool get isClockedIn => activeSession != null;

  // ── Clock In / Out ──────────────────────────────────────────────────────────

  void clockIn() {
    if (isClockedIn) return;
    _sessions.add(WorkSession(
      id: const Uuid().v4(),
      arrivalTime: DateTime.now(),
      weeklyTargetHours: _weeklyTargetHours,
    ));
    _save();
    notifyListeners();
  }

  void clockOut() {
    final idx = _sessions.indexWhere((s) => s.isActive);
    if (idx == -1) return;
    _sessions[idx] = _sessions[idx].copyWith(departureTime: DateTime.now());
    _save();
    notifyListeners();
  }

  // ── Expected departure ────────────────────────────────────────────────────

  DateTime? expectedDeparture(WorkSession session) {
    final dailySeconds = (_weeklyTargetHours / 5.0) * 3600;
    return session.arrivalTime.add(Duration(seconds: dailySeconds.round()));
  }

  // ── Weekly aggregation ────────────────────────────────────────────────────

  List<WorkSession> sessionsForWeek(DateTime week) {
    final start = _weekStart(week);
    final end = start.add(const Duration(days: 7));
    return _sessions
        .where((s) => !s.isActive &&
            s.arrivalTime.isAfter(start.subtract(const Duration(seconds: 1))) &&
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
    final target = _weeklyTargetHours * 3600;
    if (target == 0) return 0;
    return (worked / target).clamp(0.0, 1.0);
  }

  // ── Current week (live — includes ongoing session) ────────────────────────

  Duration get currentWeekTotal {
    final complete = sessionsForWeek(DateTime.now())
        .map((s) => s.duration ?? Duration.zero)
        .fold(Duration.zero, (a, b) => a + b);
    if (activeSession != null) {
      final ongoing = DateTime.now().difference(activeSession!.arrivalTime);
      return complete + ongoing;
    }
    return complete;
  }

  double get currentWeekProgress {
    final target = _weeklyTargetHours * 3600;
    if (target == 0) return 0;
    return (currentWeekTotal.inSeconds / target).clamp(0.0, 1.0);
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

  // ── Settings ──────────────────────────────────────────────────────────────

  Future<void> setWeeklyTarget(double hours) async {
    _weeklyTargetHours = hours;
    _hasCompletedOnboarding = true;
    _save();
    notifyListeners();
  }

  // ── Persistence ───────────────────────────────────────────────────────────

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _weeklyTargetHours = prefs.getDouble(_targetKey) ?? 35.0;
    _hasCompletedOnboarding = prefs.getBool(_onboardingKey) ?? false;
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
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  DateTime _weekStart(DateTime d) {
    // Week starts Monday
    final daysFromMonday = (d.weekday - 1) % 7;
    final monday = DateTime(d.year, d.month, d.day)
        .subtract(Duration(days: daysFromMonday));
    return monday;
  }
}
