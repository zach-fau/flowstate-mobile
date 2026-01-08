import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/timer_provider.dart';
import '../../theme/app_theme.dart';

/// Main timer screen - the home screen of the app.
class TimerScreen extends ConsumerWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerStatus = ref.watch(timerProvider);
    final presets = ref.watch(timerPresetsProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Header
              _buildHeader(context),

              const Spacer(),

              // Timer display
              _TimerDisplay(timerStatus: timerStatus),

              const SizedBox(height: 48),

              // Duration presets
              _PresetButtonRow(
                presets: presets,
                timerStatus: timerStatus,
                onPresetSelected: (duration) {
                  ref.read(timerProvider.notifier).setDuration(duration);
                },
              ),

              const SizedBox(height: 48),

              // Control buttons
              _ControlButtons(
                timerStatus: timerStatus,
                onStart: () => ref.read(timerProvider.notifier).start(),
                onPause: () => ref.read(timerProvider.notifier).pause(),
                onStop: () => ref.read(timerProvider.notifier).stop(),
                onComplete: () => _showNotesDialog(context, ref),
              ),

              const Spacer(),

              // Sound mixer button (placeholder)
              _buildSoundMixerButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'FlowState',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {
                // TODO: Navigate to settings screen
              },
            ),
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: () {
                // TODO: Navigate to history screen
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSoundMixerButton(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        // TODO: Show sound mixer bottom sheet
      },
      icon: const Icon(Icons.music_note, size: 20),
      label: const Text('Ambient Sounds'),
    );
  }

  void _showNotesDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Session Complete!',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Icon(
                  Icons.check_circle,
                  color: AppColors.success,
                  size: 28,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Add a note about what you worked on (optional)',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'What did you focus on?',
                filled: true,
                fillColor: AppColors.darkSurfaceLight,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ref.read(timerProvider.notifier).completeWithNotes(null);
                    },
                    child: const Text('Skip'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final notes = controller.text.trim();
                      Navigator.pop(context);
                      ref.read(timerProvider.notifier).completeWithNotes(
                            notes.isEmpty ? null : notes,
                          );
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Timer display with circular progress
class _TimerDisplay extends StatelessWidget {
  final TimerStatus timerStatus;

  const _TimerDisplay({required this.timerStatus});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.darkSurfaceLight,
              ),
            ),
          ),
          // Progress circle
          SizedBox(
            width: 280,
            height: 280,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: timerStatus.progress),
              duration: const Duration(milliseconds: 300),
              builder: (context, value, child) {
                return CircularProgressIndicator(
                  value: value,
                  strokeWidth: 8,
                  strokeCap: StrokeCap.round,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getProgressColor(timerStatus.state),
                  ),
                );
              },
            ),
          ),
          // Time display
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                timerStatus.formattedTime,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontFeatures: [const FontFeature.tabularFigures()],
                    ),
              ),
              if (timerStatus.state != TimerState.idle)
                Text(
                  _getStateLabel(timerStatus.state),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: _getProgressColor(timerStatus.state),
                      ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getProgressColor(TimerState state) {
    switch (state) {
      case TimerState.running:
        return AppColors.primary;
      case TimerState.paused:
        return AppColors.warning;
      case TimerState.completed:
        return AppColors.success;
      case TimerState.idle:
        return AppColors.primary;
    }
  }

  String _getStateLabel(TimerState state) {
    switch (state) {
      case TimerState.running:
        return 'Focusing...';
      case TimerState.paused:
        return 'Paused';
      case TimerState.completed:
        return 'Complete!';
      case TimerState.idle:
        return '';
    }
  }
}

/// Row of preset duration buttons
class _PresetButtonRow extends StatelessWidget {
  final List<int> presets;
  final TimerStatus timerStatus;
  final ValueChanged<int> onPresetSelected;

  const _PresetButtonRow({
    required this.presets,
    required this.timerStatus,
    required this.onPresetSelected,
  });

  @override
  Widget build(BuildContext context) {
    final selectedDuration = timerStatus.totalSeconds ~/ 60;
    final canSelect = timerStatus.state == TimerState.idle;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: presets.map((duration) {
        final isSelected = selectedDuration == duration;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: _PresetButton(
            duration: duration,
            isSelected: isSelected,
            enabled: canSelect,
            onTap: canSelect ? () => onPresetSelected(duration) : null,
          ),
        );
      }).toList(),
    );
  }
}

/// Preset duration button widget
class _PresetButton extends StatelessWidget {
  final int duration;
  final bool isSelected;
  final bool enabled;
  final VoidCallback? onTap;

  const _PresetButton({
    required this.duration,
    required this.isSelected,
    required this.enabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final opacity = enabled ? 1.0 : 0.5;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.darkSurface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.darkSurfaceLight,
          ),
        ),
        child: Opacity(
          opacity: opacity,
          child: Text(
            '$duration min',
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textSecondaryDark,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

/// Control buttons (Start/Pause/Stop)
class _ControlButtons extends StatelessWidget {
  final TimerStatus timerStatus;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onStop;
  final VoidCallback onComplete;

  const _ControlButtons({
    required this.timerStatus,
    required this.onStart,
    required this.onPause,
    required this.onStop,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    switch (timerStatus.state) {
      case TimerState.idle:
        return _buildStartButton();
      case TimerState.running:
        return _buildRunningButtons();
      case TimerState.paused:
        return _buildPausedButtons();
      case TimerState.completed:
        return _buildCompletedButton();
    }
  }

  Widget _buildStartButton() {
    return SizedBox(
      width: 200,
      height: 56,
      child: ElevatedButton(
        onPressed: onStart,
        child: const Text(
          'Start Focus',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildRunningButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 120,
          height: 56,
          child: OutlinedButton(
            onPressed: onStop,
            child: const Text('Stop'),
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 120,
          height: 56,
          child: ElevatedButton(
            onPressed: onPause,
            child: const Text('Pause'),
          ),
        ),
      ],
    );
  }

  Widget _buildPausedButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 120,
          height: 56,
          child: OutlinedButton(
            onPressed: onStop,
            child: const Text('Stop'),
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 120,
          height: 56,
          child: ElevatedButton(
            onPressed: onStart,
            child: const Text('Resume'),
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedButton() {
    return SizedBox(
      width: 200,
      height: 56,
      child: ElevatedButton(
        onPressed: onComplete,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.success,
        ),
        child: const Text(
          'Complete Session',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
