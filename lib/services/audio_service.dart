import 'package:audioplayers/audioplayers.dart';
import '../models/sound.dart';

/// Manages audio playback for ambient sounds.
///
/// Supports multiple simultaneous sounds with individual volume controls.
class AudioService {
  static final AudioService _instance = AudioService._internal();
  static AudioService get instance => _instance;

  AudioService._internal();

  /// Map of sound ID to audio player
  final Map<String, AudioPlayer> _players = {};

  /// Map of sound ID to current volume (0.0 - 1.0)
  final Map<String, double> _volumes = {};

  /// Map of sound ID to playing state
  final Map<String, bool> _isPlaying = {};

  /// Whether the service has been initialized
  bool _initialized = false;

  /// Check if service is initialized
  bool get isInitialized => _initialized;

  /// Initialize the audio service
  Future<void> initialize() async {
    if (_initialized) return;

    // Pre-create players for all available sounds
    for (final sound in AvailableSounds.all) {
      _players[sound.id] = AudioPlayer();
      _volumes[sound.id] = 0.5; // Default volume
      _isPlaying[sound.id] = false;

      // Set up loop mode
      await _players[sound.id]!.setReleaseMode(ReleaseMode.loop);
    }

    _initialized = true;
  }

  /// Play a sound by ID
  Future<void> play(String soundId) async {
    if (!_initialized) return;

    final sound = AvailableSounds.byId(soundId);
    if (sound == null) return;

    final player = _players[soundId];
    if (player == null) return;

    // Set the source and play
    await player.setSourceAsset(sound.assetPath.replaceFirst('assets/', ''));
    await player.setVolume(_volumes[soundId] ?? 0.5);
    await player.resume();

    _isPlaying[soundId] = true;
  }

  /// Pause a sound by ID
  Future<void> pause(String soundId) async {
    if (!_initialized) return;

    final player = _players[soundId];
    if (player == null) return;

    await player.pause();
    _isPlaying[soundId] = false;
  }

  /// Stop a sound by ID
  Future<void> stop(String soundId) async {
    if (!_initialized) return;

    final player = _players[soundId];
    if (player == null) return;

    await player.stop();
    _isPlaying[soundId] = false;
  }

  /// Toggle playback for a sound
  Future<void> toggle(String soundId) async {
    if (isPlaying(soundId)) {
      await pause(soundId);
    } else {
      await play(soundId);
    }
  }

  /// Set volume for a specific sound (0.0 - 1.0)
  Future<void> setVolume(String soundId, double volume) async {
    if (!_initialized) return;

    // Clamp volume to valid range
    volume = volume.clamp(0.0, 1.0);

    _volumes[soundId] = volume;

    final player = _players[soundId];
    if (player != null) {
      await player.setVolume(volume);
    }
  }

  /// Get volume for a specific sound
  double getVolume(String soundId) {
    return _volumes[soundId] ?? 0.5;
  }

  /// Check if a sound is currently playing
  bool isPlaying(String soundId) {
    return _isPlaying[soundId] ?? false;
  }

  /// Get list of all currently playing sound IDs
  List<String> get activeSounds {
    return _isPlaying.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
  }

  /// Stop all sounds
  Future<void> stopAll() async {
    for (final soundId in _players.keys) {
      await stop(soundId);
    }
  }

  /// Pause all sounds
  Future<void> pauseAll() async {
    for (final soundId in _players.keys) {
      if (isPlaying(soundId)) {
        await pause(soundId);
      }
    }
  }

  /// Resume previously playing sounds
  Future<void> resumeAll(List<String> soundIds) async {
    for (final soundId in soundIds) {
      await play(soundId);
    }
  }

  /// Set master volume for all sounds (multiplier)
  Future<void> setMasterVolume(double masterVolume) async {
    if (!_initialized) return;

    masterVolume = masterVolume.clamp(0.0, 1.0);

    for (final entry in _volumes.entries) {
      final player = _players[entry.key];
      if (player != null) {
        await player.setVolume(entry.value * masterVolume);
      }
    }
  }

  /// Get all volume settings as a map
  Map<String, double> getAllVolumes() {
    return Map.from(_volumes);
  }

  /// Restore volume settings from a saved map
  Future<void> restoreVolumes(Map<String, double> volumes) async {
    for (final entry in volumes.entries) {
      await setVolume(entry.key, entry.value);
    }
  }

  /// Dispose of all audio players
  Future<void> dispose() async {
    for (final player in _players.values) {
      await player.dispose();
    }
    _players.clear();
    _volumes.clear();
    _isPlaying.clear();
    _initialized = false;
  }
}
