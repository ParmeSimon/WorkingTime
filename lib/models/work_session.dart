import 'dart:convert';

class WorkSession {
  final String id;
  final DateTime arrivalTime;
  final DateTime? departureTime;
  final double weeklyTargetHours;

  WorkSession({
    required this.id,
    required this.arrivalTime,
    this.departureTime,
    required this.weeklyTargetHours,
  });

  bool get isActive => departureTime == null;

  Duration? get duration {
    if (departureTime == null) return null;
    return departureTime!.difference(arrivalTime);
  }

  String get formattedDuration {
    if (isActive) return 'En cours';
    return _formatDuration(duration!);
  }

  WorkSession copyWith({
    String? id,
    DateTime? arrivalTime,
    DateTime? departureTime,
    double? weeklyTargetHours,
    bool clearDeparture = false,
  }) {
    return WorkSession(
      id: id ?? this.id,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      departureTime: clearDeparture ? null : (departureTime ?? this.departureTime),
      weeklyTargetHours: weeklyTargetHours ?? this.weeklyTargetHours,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'arrivalTime': arrivalTime.toIso8601String(),
        'departureTime': departureTime?.toIso8601String(),
        'weeklyTargetHours': weeklyTargetHours,
      };

  factory WorkSession.fromJson(Map<String, dynamic> json) => WorkSession(
        id: json['id'] as String,
        arrivalTime: DateTime.parse(json['arrivalTime'] as String),
        departureTime: json['departureTime'] != null
            ? DateTime.parse(json['departureTime'] as String)
            : null,
        weeklyTargetHours: (json['weeklyTargetHours'] as num).toDouble(),
      );
}

String formatDuration(Duration d) => _formatDuration(d);

String _formatDuration(Duration d) {
  final h = d.inHours;
  final m = d.inMinutes.remainder(60);
  return '${h}h${m.toString().padLeft(2, '0')}';
}

List<WorkSession> sessionsFromJsonString(String s) {
  final list = jsonDecode(s) as List<dynamic>;
  return list.map((e) => WorkSession.fromJson(e as Map<String, dynamic>)).toList();
}

String sessionsToJsonString(List<WorkSession> sessions) {
  return jsonEncode(sessions.map((s) => s.toJson()).toList());
}
