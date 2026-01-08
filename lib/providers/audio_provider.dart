import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/sound.dart';
import '../services/audio_service.dart';

/// State for a single sound player
class SoundState {
  final String soundId;
  final String name;
  final String iconName;
  final bool isPlaying;
  final double volume;
  final bool isFree;

  const SoundState({
    required this.soundId,
    required this.name,
    required this.iconName,
    this.isPlaying = false,
    this.volume = 0.5,
    this.isFree = true,
  });

  SoundState copyWith({
    bool? isPlaying,
    double? volume,
  }) {
    return SoundState(
      soundId: soundId,
      name: name,
      iconName: iconName,
      isPlaying: isPlaying ?? this.isPlaying,
      volume: volume ?? this.volume,
      isFree: isFree,
    );
  }

  factory SoundState.fromSound(Sound sound) {
    return SoundState(
      soundId: sound.id,
      name: sound.name,
      iconName: sound.iconName,
      isFree: sound.isFree,
    );
  }
}

/// State for the entire audio mixer
class AudioMixerState {
  final Map<String, SoundState> sounds;
  final bool isInitialized;
  final double masterVolume;

  const AudioMixerState({
    this.sounds = const {},
    this.isInitialized = false,
    this.masterVolume = 1.0,
  });

  /// Get list of currently active (playing) sounds
  List<String> get activeSoundIds =>
      sounds.values.where((s) => s.isPlaying).map((s) => s.soundId).toList();

  /// Get list of all available sounds
  List<SoundState> get allSounds => sounds.values.toList();

  /// Check if any sound is playing
  bool get hasActiveSounds => sounds.values.any((s) => s.isPlaying);

  AudioMixerState copyWith({
    Map<String, SoundState>? sounds,
    bool? isInitialized,
    double? masterVolume,
  }) {
    return AudioMixerState(
      sounds: sounds ?? this.sounds,
      isInitialized: isInitialized ?? this.isInitialized,
      masterVolume: masterVolume ?? this.masterVolume,
    );
  }
}

/// Notifier for managing audio playback state
class AudioMixerNotifier extends StateNotifier<AudioMixerState> {
  AudioMixerNotifier() : super(const AudioMixerState());

  /// Initialize the audio mixer
  Future<void> initialize() async {
    if (state.isInitialized) return;

    await AudioService.instance.initialize();

    // Create sound states for all available sounds
    final sounds = <String, SoundState>{};
    for (final sound in AvailableSounds.all) {
      sounds[sound.id] = SoundState.fromSound(sound);
    }

    state = state.copyWith(
      sounds: sounds,
      isInitialized: true,
    );
  }

  /// Toggle a sound on/off
  Future<void> toggleSound(String soundId) async {
    if (!state.isInitialized) return;

    final soundState = state.sounds[soundId];
    if (soundState == null) return;

    await AudioService.instance.toggle(soundId);

    final newSounds = Map<String, SoundState>.from(state.sounds);
    newSounds[soundId] = soundState.copyWith(
      isPlaying: !soundState.isPlaying,
    );

    state = state.copyWith(sounds: newSounds);
  }

  /// Set volume for a specific sound
  Future<void> setVolume(String soundId, double volume) async {
    if (!state.isInitialized) return;

    final soundState = state.sounds[soundId];
    if (soundState == null) return;

    await AudioService.instance.setVolume(soundId, volume);

    final newSounds = Map<String, SoundState>.from(state.sounds);
    newSounds[soundId] = soundState.copyWith(volume: volume);

    state = state.copyWith(sounds: newSounds);
  }

  /// Set master volume (affects all sounds)
  Future<void> setMasterVolume(double volume) async {
    if (!state.isInitialized) return;

    await AudioService.instance.setMasterVolume(volume);
    state = state.copyWith(masterVolume: volume);
  }

  /// Stop all sounds
  Future<void> stopAll() async {
    if (!state.isInitialized) return;

    await AudioService.instance.stopAll();

    final newSounds = state.sounds.map(
      (id, soundState) => MapEntry(id, soundState.copyWith(isPlaying: false)),
    );

    state = state.copyWith(sounds: newSounds);
  }

  /// Pause all sounds (can be resumed)
  Future<void> pauseAll() async {
    if (!state.isInitialized) return;

    await AudioService.instance.pauseAll();

    final newSounds = state.sounds.map(
      (id, soundState) => MapEntry(id, soundState.copyWith(isPlaying: false)),
    );

    state = state.copyWith(sounds: newSounds);
  }

  /// Resume specific sounds
  Future<void> resumeSounds(List<String> soundIds) async {
    if (!state.isInitialized) return;

    await AudioService.instance.resumeAll(soundIds);

    final newSounds = Map<String, SoundState>.from(state.sounds);
    for (final soundId in soundIds) {
      final soundState = newSounds[soundId];
      if (soundState != null) {
        newSounds[soundId] = soundState.copyWith(isPlaying: true);
      }
    }

    state = state.copyWith(sounds: newSounds);
  }

  /// Get all volume settings for saving
  Map<String, double> getVolumeSettings() {
    return state.sounds.map((id, soundState) => MapEntry(id, soundState.volume));
  }

  /// Restore volume settings
  Future<void> restoreVolumeSettings(Map<String, double> volumes) async {
    if (!state.isInitialized) return;

    await AudioService.instance.restoreVolumes(volumes);

    final newSounds = Map<String, SoundState>.from(state.sounds);
    for (final entry in volumes.entries) {
      final soundState = newSounds[entry.key];
      if (soundState != null) {
        newSounds[entry.key] = soundState.copyWith(volume: entry.value);
      }
    }

    state = state.copyWith(sounds: newSounds);
  }

  @override
  void dispose() {
    AudioService.instance.dispose();
    super.dispose();
  }
}

/// Provider for the audio mixer
final audioMixerProvider =
    StateNotifierProvider<AudioMixerNotifier, AudioMixerState>((ref) {
  return AudioMixerNotifier();
});

/// Provider for checking if a specific sound is playing
final isSoundPlayingProvider = Provider.family<bool, String>((ref, soundId) {
  final state = ref.watch(audioMixerProvider);
  return state.sounds[soundId]?.isPlaying ?? false;
});

/// Provider for getting the volume of a specific sound
final soundVolumeProvider = Provider.family<double, String>((ref, soundId) {
  final state = ref.watch(audioMixerProvider);
  return state.sounds[soundId]?.volume ?? 0.5;
});

/// Provider for getting list of active sound IDs
final activeSoundIdsProvider = Provider<List<String>>((ref) {
  final state = ref.watch(audioMixerProvider);
  return state.activeSoundIds;
});
