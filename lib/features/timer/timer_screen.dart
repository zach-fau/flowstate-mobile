import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_theme.dart';

/// Main timer screen - the home screen of the app.
class TimerScreen extends ConsumerStatefulWidget {
  const TimerScreen({super.key});

  @override
  ConsumerState<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends ConsumerState<TimerScreen> {
  // Default duration in minutes
  int _selectedDuration = 25;
  bool _isRunning = false;
  int _remainingSeconds = 25 * 60;

  // Preset durations
  final List<int> _presets = [25, 45, 90];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Header
              _buildHeader(),

              const Spacer(),

              // Timer display
              _buildTimerDisplay(),

              const SizedBox(height: 48),

              // Duration presets
              _buildPresetButtons(),

              const SizedBox(height: 48),

              // Start/Pause button
              _buildStartButton(),

              const Spacer(),

              // Sound mixer button (placeholder)
              _buildSoundMixerButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'FlowState',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        IconButton(
          icon: const Icon(Icons.history),
          onPressed: () {
            // TODO: Navigate to history screen
          },
        ),
      ],
    );
  }

  Widget _buildTimerDisplay() {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    final timeString =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return Column(
      children: [
        // Circular progress indicator
        SizedBox(
          width: 280,
          height: 280,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background circle
              SizedBox(
                width: 280,
                height: 280,
                child: CircularProgressIndicator(
                  value: 1.0,
                  strokeWidth: 8,
                  backgroundColor: AppColors.darkSurfaceLight,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.darkSurfaceLight,
                  ),
                ),
              ),
              // Progress circle
              SizedBox(
                width: 280,
                height: 280,
                child: CircularProgressIndicator(
                  value: _remainingSeconds / (_selectedDuration * 60),
                  strokeWidth: 8,
                  backgroundColor: Colors.transparent,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.primary,
                  ),
                ),
              ),
              // Time display
              Text(
                timeString,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontFeatures: [const FontFeature.tabularFigures()],
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPresetButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _presets.map((duration) {
        final isSelected = _selectedDuration == duration && !_isRunning;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: _PresetButton(
            duration: duration,
            isSelected: isSelected,
            onTap: _isRunning
                ? null
                : () {
                    setState(() {
                      _selectedDuration = duration;
                      _remainingSeconds = duration * 60;
                    });
                  },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStartButton() {
    return SizedBox(
      width: 200,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _isRunning = !_isRunning;
          });
          // TODO: Implement actual timer logic
        },
        child: Text(
          _isRunning ? 'Pause' : 'Start Focus',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSoundMixerButton() {
    return TextButton.icon(
      onPressed: () {
        // TODO: Show sound mixer bottom sheet
      },
      icon: const Icon(Icons.music_note, size: 20),
      label: const Text('Ambient Sounds'),
    );
  }
}

/// Preset duration button widget
class _PresetButton extends StatelessWidget {
  final int duration;
  final bool isSelected;
  final VoidCallback? onTap;

  const _PresetButton({
    required this.duration,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.darkSurface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.darkSurfaceLight,
          ),
        ),
        child: Text(
          '$duration min',
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textSecondaryDark,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
