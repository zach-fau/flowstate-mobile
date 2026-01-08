import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/focus_session.dart';
import '../services/database_service.dart';

/// Timer state enum
enum TimerState {
  idle,
  running,
  paused,
  completed,
}

/// State class for the timer
class TimerStatus {
  final TimerState state;
  final int totalSeconds;
  final int remainingSeconds;
  final String? sessionId;
  final List<String> activeSounds;

  const TimerStatus({
    required this.state,
    required this.totalSeconds,
    required this.remainingSeconds,
    this.sessionId,
    this.activeSounds = const [],
  });

  /// Default idle state with 25 minutes
  factory TimerStatus.initial() {
    return const TimerStatus(
      state: TimerState.idle,
      totalSeconds: 25 * 60,
      remainingSeconds: 25 * 60,
    );
  }

  /// Progress from 0.0 to 1.0
  double get progress {
    if (totalSeconds == 0) return 0;
    return remainingSeconds / totalSeconds;
  }

  /// Formatted time string (MM:SS)
  String get formattedTime {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Whether the timer can be started
  bool get canStart => state == TimerState.idle || state == TimerState.paused;

  /// Whether the timer is active (running or paused)
  bool get isActive => state == TimerState.running || state == TimerState.paused;

  TimerStatus copyWith({
    TimerState? state,
    int? totalSeconds,
    int? remainingSeconds,
    String? sessionId,
    List<String>? activeSounds,
  }) {
    return TimerStatus(
      state: state ?? this.state,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      sessionId: sessionId ?? this.sessionId,
      activeSounds: activeSounds ?? this.activeSounds,
    );
  }
}

/// Timer controller notifier
class TimerNotifier extends StateNotifier<TimerStatus> {
  Timer? _timer;
  final Uuid _uuid = const Uuid();

  TimerNotifier() : super(TimerStatus.initial());

  /// Set the duration in minutes
  void setDuration(int minutes) {
    if (state.state != TimerState.idle) return;

    final seconds = minutes * 60;
    state = state.copyWith(
      totalSeconds: seconds,
      remainingSeconds: seconds,
    );
  }

  /// Set active sounds
  void setActiveSounds(List<String> sounds) {
    state = state.copyWith(activeSounds: sounds);
  }

  /// Start or resume the timer
  void start() {
    if (state.state == TimerState.running) return;

    // Create new session if starting fresh
    if (state.state == TimerState.idle) {
      final sessionId = _uuid.v4();
      state = state.copyWith(
        state: TimerState.running,
        sessionId: sessionId,
      );
      _createSession(sessionId);
    } else {
      // Resuming from paused
      state = state.copyWith(state: TimerState.running);
    }

    _startTimer();
  }

  /// Pause the timer
  void pause() {
    if (state.state != TimerState.running) return;

    _timer?.cancel();
    state = state.copyWith(state: TimerState.paused);
  }

  /// Stop/cancel the timer
  void stop() {
    _timer?.cancel();

    // Mark session as cancelled if one exists
    if (state.sessionId != null) {
      _cancelSession(state.sessionId!);
    }

    state = TimerStatus.initial().copyWith(
      totalSeconds: state.totalSeconds,
      remainingSeconds: state.totalSeconds,
    );
  }

  /// Reset to initial state
  void reset() {
    _timer?.cancel();
    state = TimerStatus.initial();
  }

  /// Complete the timer with optional notes
  Future<void> completeWithNotes(String? notes) async {
    if (state.sessionId != null) {
      await _completeSession(state.sessionId!, notes);
    }

    state = TimerStatus.initial().copyWith(
      totalSeconds: state.totalSeconds,
      remainingSeconds: state.totalSeconds,
    );
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.remainingSeconds > 0) {
        state = state.copyWith(
          remainingSeconds: state.remainingSeconds - 1,
        );
      } else {
        _timer?.cancel();
        state = state.copyWith(state: TimerState.completed);
      }
    });
  }

  Future<void> _createSession(String sessionId) async {
    if (!DatabaseService.isInitialized) return;

    final session = FocusSession.create(
      sessionId: sessionId,
      durationMinutes: state.totalSeconds ~/ 60,
      soundsUsed: state.activeSounds,
    );
    await DatabaseService.saveSession(session);
  }

  Future<void> _completeSession(String sessionId, String? notes) async {
    if (!DatabaseService.isInitialized) return;

    final session = await DatabaseService.findSessionById(sessionId);
    if (session != null) {
      session.complete(notes: notes);
      await DatabaseService.saveSession(session);
    }
  }

  Future<void> _cancelSession(String sessionId) async {
    if (!DatabaseService.isInitialized) return;

    final session = await DatabaseService.findSessionById(sessionId);
    if (session != null) {
      session.cancel();
      await DatabaseService.saveSession(session);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

/// Provider for the timer
final timerProvider = StateNotifierProvider<TimerNotifier, TimerStatus>((ref) {
  return TimerNotifier();
});

/// Provider for timer duration presets
final timerPresetsProvider = Provider<List<int>>((ref) {
  return [25, 45, 90]; // Pomodoro, medium, deep work
});
