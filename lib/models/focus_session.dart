import 'package:isar/isar.dart';

part 'focus_session.g.dart';

/// Represents a completed or in-progress focus session.
@collection
class FocusSession {
  Id id = Isar.autoIncrement;

  /// Unique identifier for the session
  @Index()
  late String sessionId;

  /// When the session was started
  @Index()
  late DateTime startTime;

  /// Duration of the session in minutes
  late int durationMinutes;

  /// User notes captured after the session (markdown supported)
  String? notes;

  /// Whether the session was completed (vs cancelled)
  late bool completed;

  /// List of sound IDs that were active during the session
  late List<String> soundsUsed;

  /// When the session ended (null if still in progress)
  DateTime? endTime;

  FocusSession();

  /// Create a new focus session
  factory FocusSession.create({
    required String sessionId,
    required int durationMinutes,
    List<String> soundsUsed = const [],
  }) {
    return FocusSession()
      ..sessionId = sessionId
      ..startTime = DateTime.now()
      ..durationMinutes = durationMinutes
      ..completed = false
      ..soundsUsed = soundsUsed;
  }

  /// Mark the session as completed
  void complete({String? notes}) {
    this.completed = true;
    this.endTime = DateTime.now();
    this.notes = notes;
  }

  /// Mark the session as cancelled
  void cancel() {
    this.completed = false;
    this.endTime = DateTime.now();
  }

  /// Get the actual duration of the session
  @ignore
  Duration get actualDuration {
    final end = endTime ?? DateTime.now();
    return end.difference(startTime);
  }

  @override
  String toString() {
    return 'FocusSession(id: $sessionId, duration: $durationMinutes min, completed: $completed)';
  }
}
