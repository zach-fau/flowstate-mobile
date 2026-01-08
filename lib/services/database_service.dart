import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/focus_session.dart';
import '../models/user_settings.dart';

/// Service for managing the local Isar database.
class DatabaseService {
  static Isar? _isar;

  /// Get the Isar instance (must call initialize first)
  static Isar get instance {
    if (_isar == null) {
      throw StateError('Database not initialized. Call DatabaseService.initialize() first.');
    }
    return _isar!;
  }

  /// Initialize the database
  static Future<void> initialize() async {
    if (_isar != null) return;

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [FocusSessionSchema, UserSettingsSchema],
      directory: dir.path,
    );

    // Ensure default settings exist
    await _ensureDefaultSettings();
  }

  /// Ensure default user settings exist
  static Future<void> _ensureDefaultSettings() async {
    final settings = await instance.userSettings.get(0);
    if (settings == null) {
      await instance.writeTxn(() async {
        await instance.userSettings.put(UserSettings.defaults());
      });
    }
  }

  /// Get user settings
  static Future<UserSettings> getSettings() async {
    final settings = await instance.userSettings.get(0);
    return settings ?? UserSettings.defaults();
  }

  /// Update user settings
  static Future<void> updateSettings(UserSettings settings) async {
    await instance.writeTxn(() async {
      await instance.userSettings.put(settings);
    });
  }

  /// Save a focus session
  static Future<void> saveSession(FocusSession session) async {
    await instance.writeTxn(() async {
      await instance.focusSessions.put(session);
    });
  }

  /// Get all sessions, sorted by start time (newest first)
  static Future<List<FocusSession>> getAllSessions({int limit = 100}) async {
    return await instance.focusSessions
        .where()
        .sortByStartTimeDesc()
        .limit(limit)
        .findAll();
  }

  /// Get completed sessions only
  static Future<List<FocusSession>> getCompletedSessions({int limit = 100}) async {
    return await instance.focusSessions
        .filter()
        .completedEqualTo(true)
        .sortByStartTimeDesc()
        .limit(limit)
        .findAll();
  }

  /// Search sessions by notes content
  static Future<List<FocusSession>> searchByNotes(String query) async {
    return await instance.focusSessions
        .filter()
        .notesContains(query, caseSensitive: false)
        .sortByStartTimeDesc()
        .findAll();
  }

  /// Delete a session
  static Future<void> deleteSession(int id) async {
    await instance.writeTxn(() async {
      await instance.focusSessions.delete(id);
    });
  }

  /// Close the database
  static Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }
}
