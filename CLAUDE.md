# FlowState Mobile

Minimalist focus timer app with ambient sounds for iOS and Android.

## Project Overview

FlowState is a Flutter-based focus timer targeting professionals who find gamified apps like Forest too childish. Core features: timer, ambient sound mixer, session notes, and local history.

## Tech Stack

- **Framework**: Flutter 3.x
- **State**: Riverpod (compile-time safe, testable)
- **Database**: Isar DB (local-first, pure Dart)
- **Audio**: audioplayers + flutter_background_service

## Commands

```bash
# Development
flutter pub get          # Install dependencies
flutter run              # Run in debug mode
flutter run -d chrome    # Run in web (for quick testing)

# Testing
flutter test             # Run all tests
flutter test --coverage  # Run with coverage

# Building
flutter build apk        # Android APK
flutter build appbundle  # Android App Bundle
flutter build ios        # iOS (requires macOS)
```

## Architecture

```
lib/
├── main.dart           # Entry point
├── app.dart            # MaterialApp configuration
├── features/           # Feature modules
│   ├── timer/          # Focus timer
│   ├── sounds/         # Ambient sound mixer
│   ├── notes/          # Session notes
│   └── history/        # Session history
├── models/             # Data models (FocusSession, UserSettings)
├── providers/          # Riverpod providers
└── services/           # Audio service, DB service
```

## Key Models

```dart
// Session
class FocusSession {
  final String id;
  final DateTime startTime;
  final int durationMinutes;
  final String? notes;
  final bool completed;
  final List<String> soundsUsed;
}

// Settings
class UserSettings {
  final int defaultDuration;
  final bool darkMode;
  final Map<String, double> soundVolumes;
  final String preferredSound;
}
```

## Task Tracking

GitHub Issues are the source of truth. Check `gh issue list` for current work.

## Development Guidelines

1. **Feature branches only** - Never push directly to main
2. **Tests required** - All features need tests before merge
3. **Commit format**: `Issue #X: Description`
4. **Dark mode first** - Default theme is dark
