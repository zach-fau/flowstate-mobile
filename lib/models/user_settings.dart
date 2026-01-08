import 'package:isar/isar.dart';

part 'user_settings.g.dart';

/// User preferences and app settings.
/// Only one instance should exist in the database.
@collection
class UserSettings {
  Id id = 0; // Fixed ID - only one settings instance

  /// Default timer duration in minutes
  late int defaultDuration;

  /// Whether dark mode is enabled (default: true)
  late bool darkMode;

  /// Volume levels for each sound (0.0 to 1.0)
  /// Stored as JSON-encoded map
  String soundVolumesJson = '{}';

  /// The preferred/default sound to play
  String? preferredSound;

  /// Whether to show session notes prompt after completion
  late bool showNotesPrompt;

  /// Whether vibration is enabled for notifications
  late bool vibrationEnabled;

  /// Notification sound name
  String notificationSound = 'gentle';

  UserSettings();

  /// Create default settings
  factory UserSettings.defaults() {
    return UserSettings()
      ..defaultDuration = 25 // Pomodoro default
      ..darkMode = true
      ..soundVolumesJson = '{}'
      ..preferredSound = 'rain'
      ..showNotesPrompt = true
      ..vibrationEnabled = true
      ..notificationSound = 'gentle';
  }

  /// Get sound volumes as a Map
  @ignore
  Map<String, double> get soundVolumes {
    if (soundVolumesJson.isEmpty || soundVolumesJson == '{}') {
      return {};
    }
    // Simple parsing - in production use json decode
    final map = <String, double>{};
    // Parse format: {"rain":0.5,"cafe":0.3}
    final content = soundVolumesJson.substring(1, soundVolumesJson.length - 1);
    if (content.isEmpty) return map;

    final pairs = content.split(',');
    for (final pair in pairs) {
      final parts = pair.split(':');
      if (parts.length == 2) {
        final key = parts[0].replaceAll('"', '').trim();
        final value = double.tryParse(parts[1].trim()) ?? 0.5;
        map[key] = value;
      }
    }
    return map;
  }

  /// Set sound volumes from a Map
  set soundVolumes(Map<String, double> volumes) {
    if (volumes.isEmpty) {
      soundVolumesJson = '{}';
      return;
    }
    final entries =
        volumes.entries.map((e) => '"${e.key}":${e.value}').join(',');
    soundVolumesJson = '{$entries}';
  }

  /// Update volume for a specific sound
  void setSoundVolume(String soundId, double volume) {
    final volumes = soundVolumes;
    volumes[soundId] = volume.clamp(0.0, 1.0);
    this.soundVolumes = volumes;
  }

  /// Get volume for a specific sound (default 0.5)
  double getSoundVolume(String soundId) {
    return soundVolumes[soundId] ?? 0.5;
  }

  @override
  String toString() {
    return 'UserSettings(defaultDuration: $defaultDuration, darkMode: $darkMode)';
  }
}
