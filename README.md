# FlowState Mobile

A minimalist focus timer app with ambient sounds - the anti-Forest for professionals.

## Overview

FlowState is a clean, minimal focus workspace for developers, students, and knowledge workers who find gamified apps like Forest too childish. Just a timer, ambient sounds, and quick notes to capture thoughts without leaving your flow state.

**No achievements. No virtual rewards. No social features. Just focus.**

## Features

- **Focus Timer** - Presets (25/45/90 min) + custom duration, circular progress visualization
- **Ambient Sound Mixer** - Rain, cafe, white noise, nature sounds with individual volume controls
- **Session Notes** - Quick markdown notes after each session
- **Session History** - Track your focus patterns (local-only, privacy-first)
- **Dark Mode** - Default theme for late night work

## Tech Stack

- **Framework**: Flutter (cross-platform iOS/Android)
- **State Management**: Riverpod
- **Database**: Isar DB (local-first)
- **Audio**: audioplayers + flutter_background_service

## Project Structure

```
lib/
├── main.dart
├── app.dart
├── features/
│   ├── timer/
│   ├── sounds/
│   ├── notes/
│   └── history/
├── models/
├── providers/
└── services/
```

## Development

```bash
# Get dependencies
flutter pub get

# Run in debug mode
flutter run

# Run tests
flutter test

# Build for release
flutter build apk
flutter build ios
```

## License

MIT
