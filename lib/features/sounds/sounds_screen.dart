import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/audio_provider.dart';

/// Screen for mixing ambient sounds
class SoundsScreen extends ConsumerStatefulWidget {
  const SoundsScreen({super.key});

  @override
  ConsumerState<SoundsScreen> createState() => _SoundsScreenState();
}

class _SoundsScreenState extends ConsumerState<SoundsScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize audio on first load
    Future.microtask(() {
      ref.read(audioMixerProvider.notifier).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mixerState = ref.watch(audioMixerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        title: const Text(
          'Ambient Sounds',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (mixerState.hasActiveSounds)
            IconButton(
              icon: const Icon(Icons.stop, color: Colors.white70),
              onPressed: () {
                ref.read(audioMixerProvider.notifier).stopAll();
              },
              tooltip: 'Stop All',
            ),
        ],
      ),
      body: mixerState.isInitialized
          ? _buildSoundGrid(mixerState)
          : const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF6366F1),
              ),
            ),
    );
  }

  Widget _buildSoundGrid(AudioMixerState mixerState) {
    final sounds = mixerState.allSounds;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info text
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF252545),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.white.withOpacity(0.7),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Mix multiple sounds together for your perfect focus environment',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Sound cards
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: sounds.length,
              itemBuilder: (context, index) {
                return _SoundCard(soundState: sounds[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Card widget for a single sound with toggle and volume control
class _SoundCard extends ConsumerWidget {
  final SoundState soundState;

  const _SoundCard({required this.soundState});

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'water_drop':
        return Icons.water_drop;
      case 'waves':
        return Icons.waves;
      case 'local_cafe':
        return Icons.local_cafe;
      case 'forest':
        return Icons.forest;
      default:
        return Icons.music_note;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlaying = soundState.isPlaying;
    final volume = soundState.volume;

    return GestureDetector(
      onTap: () {
        ref.read(audioMixerProvider.notifier).toggleSound(soundState.soundId);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isPlaying
              ? const Color(0xFF6366F1).withOpacity(0.2)
              : const Color(0xFF252545),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isPlaying
                ? const Color(0xFF6366F1)
                : Colors.white.withOpacity(0.1),
            width: isPlaying ? 2 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with animated glow
              Stack(
                alignment: Alignment.center,
                children: [
                  if (isPlaying)
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF6366F1).withOpacity(0.3),
                      ),
                    ),
                  Icon(
                    _getIconData(soundState.iconName),
                    size: 40,
                    color: isPlaying ? const Color(0xFF6366F1) : Colors.white70,
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Sound name
              Text(
                soundState.name,
                style: TextStyle(
                  color: isPlaying ? Colors.white : Colors.white70,
                  fontSize: 16,
                  fontWeight: isPlaying ? FontWeight.w600 : FontWeight.w500,
                ),
              ),

              // Premium badge if not free
              if (!soundState.isFree) ...[
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'PRO',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],

              const Spacer(),

              // Volume slider (only show when playing)
              if (isPlaying) ...[
                Text(
                  'Volume',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
                SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 4,
                    activeTrackColor: const Color(0xFF6366F1),
                    inactiveTrackColor: Colors.white.withOpacity(0.2),
                    thumbColor: Colors.white,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 6),
                    overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 12),
                  ),
                  child: Slider(
                    value: volume,
                    min: 0,
                    max: 1,
                    onChanged: (value) {
                      ref
                          .read(audioMixerProvider.notifier)
                          .setVolume(soundState.soundId, value);
                    },
                  ),
                ),
              ] else ...[
                // Tap to play hint
                Text(
                  'Tap to play',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
