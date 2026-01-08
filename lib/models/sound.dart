/// Represents an ambient sound that can be played.
class Sound {
  /// Unique identifier for the sound
  final String id;

  /// Display name
  final String name;

  /// Asset path to the audio file
  final String assetPath;

  /// Icon to display (Material icon name)
  final String iconName;

  /// Whether this sound is available in the free tier
  final bool isFree;

  const Sound({
    required this.id,
    required this.name,
    required this.assetPath,
    required this.iconName,
    this.isFree = true,
  });

  @override
  String toString() => 'Sound($id: $name)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Sound && other.id == id);

  @override
  int get hashCode => id.hashCode;
}

/// Available ambient sounds
class AvailableSounds {
  static const rain = Sound(
    id: 'rain',
    name: 'Rain',
    assetPath: 'assets/sounds/rain.mp3',
    iconName: 'water_drop',
    isFree: true,
  );

  static const whiteNoise = Sound(
    id: 'white_noise',
    name: 'White Noise',
    assetPath: 'assets/sounds/white_noise.mp3',
    iconName: 'waves',
    isFree: true,
  );

  static const cafe = Sound(
    id: 'cafe',
    name: 'Cafe',
    assetPath: 'assets/sounds/cafe.mp3',
    iconName: 'local_cafe',
    isFree: false, // Premium
  );

  static const nature = Sound(
    id: 'nature',
    name: 'Nature',
    assetPath: 'assets/sounds/nature.mp3',
    iconName: 'forest',
    isFree: false, // Premium
  );

  /// All available sounds
  static const List<Sound> all = [rain, whiteNoise, cafe, nature];

  /// Only free sounds
  static List<Sound> get free => all.where((s) => s.isFree).toList();

  /// Get sound by ID
  static Sound? byId(String id) {
    try {
      return all.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }
}
