import 'package:flutter_test/flutter_test.dart';
import 'package:flowstate_mobile/models/sound.dart';

void main() {
  group('Sound', () {
    test('equality is based on id', () {
      const sound1 = Sound(
        id: 'rain',
        name: 'Rain',
        assetPath: 'assets/sounds/rain.mp3',
        iconName: 'water_drop',
      );

      const sound2 = Sound(
        id: 'rain',
        name: 'Different Name',
        assetPath: 'different/path.mp3',
        iconName: 'different_icon',
      );

      expect(sound1, equals(sound2));
    });

    test('hashCode is based on id', () {
      const sound1 = Sound(
        id: 'rain',
        name: 'Rain',
        assetPath: 'assets/sounds/rain.mp3',
        iconName: 'water_drop',
      );

      const sound2 = Sound(
        id: 'rain',
        name: 'Different Name',
        assetPath: 'different/path.mp3',
        iconName: 'different_icon',
      );

      expect(sound1.hashCode, equals(sound2.hashCode));
    });
  });

  group('AvailableSounds', () {
    test('all contains expected sounds', () {
      expect(AvailableSounds.all.length, 4);
      expect(AvailableSounds.all.map((s) => s.id),
          containsAll(['rain', 'white_noise', 'cafe', 'nature']));
    });

    test('free returns only free sounds', () {
      final freeSounds = AvailableSounds.free;

      expect(freeSounds.every((s) => s.isFree), true);
      expect(freeSounds.length, 2);
      expect(freeSounds.map((s) => s.id), containsAll(['rain', 'white_noise']));
    });

    test('byId returns correct sound', () {
      final rain = AvailableSounds.byId('rain');
      expect(rain?.id, 'rain');
      expect(rain?.name, 'Rain');

      final cafe = AvailableSounds.byId('cafe');
      expect(cafe?.id, 'cafe');
      expect(cafe?.isFree, false);
    });

    test('byId returns null for unknown id', () {
      final unknown = AvailableSounds.byId('unknown_sound');
      expect(unknown, isNull);
    });
  });
}
