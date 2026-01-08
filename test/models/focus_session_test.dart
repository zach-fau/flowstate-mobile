import 'package:flutter_test/flutter_test.dart';
import 'package:flowstate_mobile/models/focus_session.dart';

void main() {
  group('FocusSession', () {
    test('create() sets initial values correctly', () {
      final session = FocusSession.create(
        sessionId: 'test-123',
        durationMinutes: 25,
        soundsUsed: ['rain', 'white_noise'],
      );

      expect(session.sessionId, 'test-123');
      expect(session.durationMinutes, 25);
      expect(session.completed, false);
      expect(session.soundsUsed, ['rain', 'white_noise']);
      expect(session.notes, isNull);
      expect(session.endTime, isNull);
      expect(session.startTime, isNotNull);
    });

    test('complete() marks session as completed with notes', () {
      final session = FocusSession.create(
        sessionId: 'test-456',
        durationMinutes: 45,
      );

      session.complete(notes: 'Great focus session!');

      expect(session.completed, true);
      expect(session.notes, 'Great focus session!');
      expect(session.endTime, isNotNull);
    });

    test('cancel() marks session as not completed', () {
      final session = FocusSession.create(
        sessionId: 'test-789',
        durationMinutes: 90,
      );

      session.cancel();

      expect(session.completed, false);
      expect(session.endTime, isNotNull);
    });

    test('actualDuration calculates correctly', () async {
      final session = FocusSession.create(
        sessionId: 'test-duration',
        durationMinutes: 25,
      );

      // Wait a bit to create some duration
      await Future.delayed(const Duration(milliseconds: 100));

      final duration = session.actualDuration;
      expect(duration.inMilliseconds, greaterThanOrEqualTo(100));
    });
  });
}
