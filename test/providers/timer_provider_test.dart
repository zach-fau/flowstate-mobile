import 'package:flutter_test/flutter_test.dart';
import 'package:flowstate_mobile/providers/timer_provider.dart';

void main() {
  group('TimerStatus', () {
    test('initial() creates idle timer with 25 minutes', () {
      final status = TimerStatus.initial();

      expect(status.state, TimerState.idle);
      expect(status.totalSeconds, 25 * 60);
      expect(status.remainingSeconds, 25 * 60);
      expect(status.sessionId, isNull);
      expect(status.activeSounds, isEmpty);
    });

    test('progress is 1.0 at start', () {
      final status = TimerStatus.initial();
      expect(status.progress, 1.0);
    });

    test('progress is 0.5 at midpoint', () {
      final status = TimerStatus(
        state: TimerState.running,
        totalSeconds: 100,
        remainingSeconds: 50,
      );
      expect(status.progress, 0.5);
    });

    test('progress is 0.0 when completed', () {
      final status = TimerStatus(
        state: TimerState.completed,
        totalSeconds: 100,
        remainingSeconds: 0,
      );
      expect(status.progress, 0.0);
    });

    test('formattedTime formats correctly', () {
      expect(
        const TimerStatus(
          state: TimerState.idle,
          totalSeconds: 25 * 60,
          remainingSeconds: 25 * 60,
        ).formattedTime,
        '25:00',
      );

      expect(
        const TimerStatus(
          state: TimerState.idle,
          totalSeconds: 90 * 60,
          remainingSeconds: 5 * 60 + 30,
        ).formattedTime,
        '05:30',
      );

      expect(
        const TimerStatus(
          state: TimerState.idle,
          totalSeconds: 60,
          remainingSeconds: 59,
        ).formattedTime,
        '00:59',
      );
    });

    test('canStart is true for idle and paused states', () {
      expect(
        const TimerStatus(
          state: TimerState.idle,
          totalSeconds: 100,
          remainingSeconds: 100,
        ).canStart,
        true,
      );

      expect(
        const TimerStatus(
          state: TimerState.paused,
          totalSeconds: 100,
          remainingSeconds: 50,
        ).canStart,
        true,
      );

      expect(
        const TimerStatus(
          state: TimerState.running,
          totalSeconds: 100,
          remainingSeconds: 50,
        ).canStart,
        false,
      );

      expect(
        const TimerStatus(
          state: TimerState.completed,
          totalSeconds: 100,
          remainingSeconds: 0,
        ).canStart,
        false,
      );
    });

    test('isActive is true for running and paused states', () {
      expect(
        const TimerStatus(
          state: TimerState.running,
          totalSeconds: 100,
          remainingSeconds: 50,
        ).isActive,
        true,
      );

      expect(
        const TimerStatus(
          state: TimerState.paused,
          totalSeconds: 100,
          remainingSeconds: 50,
        ).isActive,
        true,
      );

      expect(
        const TimerStatus(
          state: TimerState.idle,
          totalSeconds: 100,
          remainingSeconds: 100,
        ).isActive,
        false,
      );
    });

    test('copyWith preserves unchanged values', () {
      const original = TimerStatus(
        state: TimerState.running,
        totalSeconds: 100,
        remainingSeconds: 50,
        sessionId: 'test-id',
        activeSounds: ['rain'],
      );

      final modified = original.copyWith(remainingSeconds: 40);

      expect(modified.state, TimerState.running);
      expect(modified.totalSeconds, 100);
      expect(modified.remainingSeconds, 40);
      expect(modified.sessionId, 'test-id');
      expect(modified.activeSounds, ['rain']);
    });
  });

  group('TimerNotifier', () {
    test('setDuration updates total and remaining seconds', () {
      final notifier = TimerNotifier();

      notifier.setDuration(45);

      expect(notifier.state.totalSeconds, 45 * 60);
      expect(notifier.state.remainingSeconds, 45 * 60);
    });

    test('setDuration does nothing when timer is running', () {
      final notifier = TimerNotifier();
      notifier.start();

      notifier.setDuration(45);

      // Should still be 25 minutes (default)
      expect(notifier.state.totalSeconds, 25 * 60);

      notifier.dispose();
    });

    test('start changes state to running', () {
      final notifier = TimerNotifier();

      notifier.start();

      expect(notifier.state.state, TimerState.running);
      expect(notifier.state.sessionId, isNotNull);

      notifier.dispose();
    });

    test('pause changes state to paused', () {
      final notifier = TimerNotifier();
      notifier.start();

      notifier.pause();

      expect(notifier.state.state, TimerState.paused);

      notifier.dispose();
    });

    test('resume from paused changes state back to running', () {
      final notifier = TimerNotifier();
      notifier.start();
      notifier.pause();

      notifier.start();

      expect(notifier.state.state, TimerState.running);

      notifier.dispose();
    });

    test('stop resets to idle with same duration', () {
      final notifier = TimerNotifier();
      notifier.setDuration(45);
      notifier.start();

      notifier.stop();

      expect(notifier.state.state, TimerState.idle);
      expect(notifier.state.totalSeconds, 45 * 60);
      expect(notifier.state.remainingSeconds, 45 * 60);
      expect(notifier.state.sessionId, isNull);

      notifier.dispose();
    });

    test('reset returns to initial state', () {
      final notifier = TimerNotifier();
      notifier.setDuration(45);
      notifier.start();

      notifier.reset();

      expect(notifier.state.state, TimerState.idle);
      expect(notifier.state.totalSeconds, 25 * 60); // Back to default
      expect(notifier.state.remainingSeconds, 25 * 60);

      notifier.dispose();
    });

    test('setActiveSounds updates active sounds', () {
      final notifier = TimerNotifier();

      notifier.setActiveSounds(['rain', 'cafe']);

      expect(notifier.state.activeSounds, ['rain', 'cafe']);

      notifier.dispose();
    });
  });
}
