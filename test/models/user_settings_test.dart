import 'package:flutter_test/flutter_test.dart';
import 'package:flowstate_mobile/models/user_settings.dart';

void main() {
  group('UserSettings', () {
    test('defaults() creates settings with sensible defaults', () {
      final settings = UserSettings.defaults();

      expect(settings.defaultDuration, 25);
      expect(settings.darkMode, true);
      expect(settings.preferredSound, 'rain');
      expect(settings.showNotesPrompt, true);
      expect(settings.vibrationEnabled, true);
    });

    test('soundVolumes getter parses JSON correctly', () {
      final settings = UserSettings.defaults();
      settings.soundVolumesJson = '{"rain":0.5,"cafe":0.3}';

      final volumes = settings.soundVolumes;

      expect(volumes['rain'], 0.5);
      expect(volumes['cafe'], 0.3);
      expect(volumes.length, 2);
    });

    test('soundVolumes setter serializes map correctly', () {
      final settings = UserSettings.defaults();

      settings.soundVolumes = {'rain': 0.8, 'white_noise': 0.4};

      expect(settings.soundVolumesJson.contains('rain'), true);
      expect(settings.soundVolumesJson.contains('0.8'), true);
      expect(settings.soundVolumesJson.contains('white_noise'), true);
      expect(settings.soundVolumesJson.contains('0.4'), true);
    });

    test('setSoundVolume updates specific sound volume', () {
      final settings = UserSettings.defaults();
      settings.soundVolumes = {'rain': 0.5};

      settings.setSoundVolume('cafe', 0.7);

      expect(settings.getSoundVolume('rain'), 0.5);
      expect(settings.getSoundVolume('cafe'), 0.7);
    });

    test('getSoundVolume returns default for unknown sound', () {
      final settings = UserSettings.defaults();

      expect(settings.getSoundVolume('unknown'), 0.5);
    });

    test('setSoundVolume clamps values to 0.0-1.0', () {
      final settings = UserSettings.defaults();

      settings.setSoundVolume('rain', 1.5);
      expect(settings.getSoundVolume('rain'), 1.0);

      settings.setSoundVolume('rain', -0.5);
      expect(settings.getSoundVolume('rain'), 0.0);
    });
  });
}
