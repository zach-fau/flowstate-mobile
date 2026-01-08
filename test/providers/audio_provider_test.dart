import 'package:flutter_test/flutter_test.dart';
import 'package:flowstate_mobile/providers/audio_provider.dart';
import 'package:flowstate_mobile/models/sound.dart';

void main() {
  group('SoundState', () {
    test('fromSound creates correct state', () {
      const sound = Sound(
        id: 'test',
        name: 'Test Sound',
        assetPath: 'assets/test.mp3',
        iconName: 'test_icon',
        isFree: true,
      );

      final state = SoundState.fromSound(sound);

      expect(state.soundId, 'test');
      expect(state.name, 'Test Sound');
      expect(state.iconName, 'test_icon');
      expect(state.isFree, true);
      expect(state.isPlaying, false);
      expect(state.volume, 0.5);
    });

    test('copyWith updates only specified fields', () {
      const state = SoundState(
        soundId: 'test',
        name: 'Test',
        iconName: 'icon',
        isPlaying: false,
        volume: 0.5,
      );

      final updated = state.copyWith(isPlaying: true);

      expect(updated.isPlaying, true);
      expect(updated.volume, 0.5); // unchanged
      expect(updated.soundId, 'test'); // unchanged
    });

    test('copyWith preserves immutability', () {
      const state = SoundState(
        soundId: 'test',
        name: 'Test',
        iconName: 'icon',
        isPlaying: false,
        volume: 0.5,
      );

      final updated = state.copyWith(volume: 0.8);

      expect(state.volume, 0.5); // original unchanged
      expect(updated.volume, 0.8);
    });
  });

  group('AudioMixerState', () {
    test('initial state has no active sounds', () {
      const state = AudioMixerState();

      expect(state.sounds, isEmpty);
      expect(state.isInitialized, false);
      expect(state.activeSoundIds, isEmpty);
      expect(state.hasActiveSounds, false);
    });

    test('activeSoundIds returns only playing sounds', () {
      final state = AudioMixerState(
        sounds: {
          'rain': const SoundState(
            soundId: 'rain',
            name: 'Rain',
            iconName: 'water',
            isPlaying: true,
          ),
          'cafe': const SoundState(
            soundId: 'cafe',
            name: 'Cafe',
            iconName: 'cafe',
            isPlaying: false,
          ),
          'nature': const SoundState(
            soundId: 'nature',
            name: 'Nature',
            iconName: 'forest',
            isPlaying: true,
          ),
        },
      );

      expect(state.activeSoundIds, containsAll(['rain', 'nature']));
      expect(state.activeSoundIds, isNot(contains('cafe')));
      expect(state.hasActiveSounds, true);
    });

    test('allSounds returns all sounds', () {
      final state = AudioMixerState(
        sounds: {
          'a': const SoundState(soundId: 'a', name: 'A', iconName: 'a'),
          'b': const SoundState(soundId: 'b', name: 'B', iconName: 'b'),
        },
      );

      expect(state.allSounds.length, 2);
    });

    test('copyWith creates new state with updated fields', () {
      const state = AudioMixerState(
        isInitialized: false,
        masterVolume: 0.5,
      );

      final updated = state.copyWith(
        isInitialized: true,
        masterVolume: 0.8,
      );

      expect(updated.isInitialized, true);
      expect(updated.masterVolume, 0.8);
    });
  });

  group('AudioMixerNotifier (unit tests without audio)', () {
    late AudioMixerNotifier notifier;

    setUp(() {
      notifier = AudioMixerNotifier();
    });

    tearDown(() {
      notifier.dispose();
    });

    test('initial state is not initialized', () {
      expect(notifier.state.isInitialized, false);
      expect(notifier.state.sounds, isEmpty);
    });

    test('getVolumeSettings returns empty map for uninitialized state', () {
      final volumes = notifier.getVolumeSettings();
      expect(volumes, isEmpty);
    });
  });

  group('AvailableSounds integration', () {
    test('all sounds have valid data', () {
      for (final sound in AvailableSounds.all) {
        expect(sound.id, isNotEmpty);
        expect(sound.name, isNotEmpty);
        expect(sound.assetPath, isNotEmpty);
        expect(sound.iconName, isNotEmpty);
      }
    });

    test('SoundState can be created from all available sounds', () {
      for (final sound in AvailableSounds.all) {
        final state = SoundState.fromSound(sound);

        expect(state.soundId, sound.id);
        expect(state.name, sound.name);
        expect(state.isFree, sound.isFree);
        expect(state.isPlaying, false);
        expect(state.volume, 0.5);
      }
    });

    test('free sounds filter works correctly', () {
      final freeSounds = AvailableSounds.free;

      for (final sound in freeSounds) {
        expect(sound.isFree, true);
      }
    });

    test('byId returns correct sound', () {
      expect(AvailableSounds.byId('rain'), AvailableSounds.rain);
      expect(AvailableSounds.byId('cafe'), AvailableSounds.cafe);
      expect(AvailableSounds.byId('invalid'), isNull);
    });
  });

  group('AudioMixerState immutability', () {
    test('sounds map reference is maintained', () {
      final sounds = {
        'rain': const SoundState(
          soundId: 'rain',
          name: 'Rain',
          iconName: 'water',
        ),
      };

      final state = AudioMixerState(sounds: sounds);

      // State holds the same reference (intended for efficiency)
      // In practice, we create new maps when updating state
      expect(state.sounds.containsKey('rain'), true);
      expect(state.sounds['rain']?.name, 'Rain');
    });

    test('copyWith with sounds creates independent copy', () {
      final state1 = AudioMixerState(
        sounds: {
          'a': const SoundState(soundId: 'a', name: 'A', iconName: 'a'),
        },
      );

      final newSounds = Map<String, SoundState>.from(state1.sounds);
      newSounds['b'] = const SoundState(soundId: 'b', name: 'B', iconName: 'b');

      final state2 = state1.copyWith(sounds: newSounds);

      expect(state1.sounds.length, 1);
      expect(state2.sounds.length, 2);
    });
  });
}
