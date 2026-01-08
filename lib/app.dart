import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/app_theme.dart';
import 'features/timer/timer_screen.dart';

/// Provider for theme mode
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.dark);

/// Main application widget
class FlowStateApp extends ConsumerWidget {
  const FlowStateApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'FlowState',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      home: const TimerScreen(),
    );
  }
}
