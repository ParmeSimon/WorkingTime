import 'dart:convert';

// ── Pause ─────────────────────────────────────────────────────────────────

class WorkPause {
  final DateTime start;
  final DateTime? end;

  const WorkPause({required this.start, this.end});

  bool get isActive => end == null;

  /// Duration of this pause at a given reference time.
  /// If the pause is still ongoing, measures from start to [ref].
  Duration durationAt(DateTime ref) {
    if (end == null) return ref.difference(start);
    return end!.difference(start);
  }

  WorkPause copyWith({DateTime? end}) =>
      WorkPause(start: start, end: end ?? this.end);

  Map<String, dynamic> toJson() => {
        'start': start.toIso8601String(),
        'end': end?.toIso8601String(),
      };

  factory WorkPause.fromJson(Map<String, dynamic> json) => WorkPause(
        start: DateTime.parse(json['start'] as String),
        end: json['end'] != null
            ? DateTime.parse(json['end'] as String)
            : null,
      );
}

// ── Session ───────────────────────────────────────────────────────────────

class WorkSession {
  final String id;
  final DateTime arrivalTime;
  final DateTime? departureTime;
  final double weeklyTargetHours;
  final List<WorkPause> pauses;

  WorkSession({
    required this.id,
    required this.arrivalTime,
    this.departureTime,
    required this.weeklyTargetHours,
    this.pauses = const [],
  });

  bool get isActive => departureTime == null;
  bool get isPaused => isActive && pauses.any((p) => p.isActive);
  WorkPause? get currentPause =>
      pauses.where((p) => p.isActive).firstOrNull;

  /// Total pause time measured at [ref].
  Duration totalPauseDurationAt(DateTime ref) =>
      pauses.fold(Duration.zero, (acc, p) => acc + p.durationAt(ref));

  /// Effective (net) work duration, excluding all pauses.
  /// Returns null if the session is still active.
  Duration? get duration {
    if (departureTime == null) return null;
    final gross = departureTime!.difference(arrivalTime);
    final paused = pauses.fold(
      Duration.zero,
      (acc, p) => acc + p.durationAt(departureTime!),
    );
    return gross - paused;
  }

  String get formattedDuration {
    if (isActive) return isPaused ? 'En pause' : 'En cours';
    return _formatDuration(duration!);
  }

  WorkSession copyWith({
    String? id,
    DateTime? arrivalTime,
    DateTime? departureTime,
    double? weeklyTargetHours,
    List<WorkPause>? pauses,
    bool clearDeparture = false,
  }) {
    return WorkSession(
      id: id ?? this.id,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      departureTime:
          clearDeparture ? null : (departureTime ?? this.departureTime),
      weeklyTargetHours: weeklyTargetHours ?? this.weeklyTargetHours,
      pauses: pauses ?? this.pauses,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'arrivalTime': arrivalTime.toIso8601String(),
        'departureTime': departureTime?.toIso8601String(),
        'weeklyTargetHours': weeklyTargetHours,
        'pauses': pauses.map((p) => p.toJson()).toList(),
      };

  factory WorkSession.fromJson(Map<String, dynamic> json) => WorkSession(
        id: json['id'] as String,
        arrivalTime: DateTime.parse(json['arrivalTime'] as String),
        departureTime: json['departureTime'] != null
            ? DateTime.parse(json['departureTime'] as String)
            : null,
        weeklyTargetHours: (json['weeklyTargetHours'] as num).toDouble(),
        pauses: (json['pauses'] as List<dynamic>?)
                ?.map((e) => WorkPause.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );
}

// ── Helpers ───────────────────────────────────────────────────────────────

String formatDuration(Duration d) => _formatDuration(d);

String _formatDuration(Duration d) {
  final h = d.inHours;
  final m = d.inMinutes.remainder(60);
  return '${h}h${m.toString().padLeft(2, '0')}';
}

List<WorkSession> sessionsFromJsonString(String s) {
  final list = jsonDecode(s) as List<dynamic>;
  return list
      .map((e) => WorkSession.fromJson(e as Map<String, dynamic>))
      .toList();
}

String sessionsToJsonString(List<WorkSession> sessions) {
  return jsonEncode(sessions.map((s) => s.toJson()).toList());
}
