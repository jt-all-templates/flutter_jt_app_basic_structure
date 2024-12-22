import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:jt_app_basic_structure/data/models/save/user_settings.dart';
import 'package:jt_app_basic_structure/utils/save/share_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettingProvider extends ChangeNotifier {
  UserSettings? _userSettings;
  UserSettings? get userSettings => _userSettings;

  late final Future<void> initializationFuture;

  UserSettingProvider() {
    initializationFuture = _initializeSettings();
  }

  Future<void> _initializeSettings() async {
    try {
      _userSettings = await _loadUserSettings();
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<UserSettings> _loadUserSettings() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userSettingString =
          prefs.getString(SharePreferencesKeys.userSettingKey);
      if (userSettingString == null) {
        return UserSettings();
      }
      Map<String, dynamic> decodedJson = json.decode(userSettingString);
      final settings = UserSettings.fromJson(decodedJson);
      return settings;
    } catch (e) {
      print('Error loading user settings: $e');
      return UserSettings();
    }
  }

  Future<void> saveUserSettings() async {
    if (_userSettings == null) {
      throw Exception('Cannot save null settings');
    }
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String saveString = json.encode(_userSettings!.toJson());
      final success = await prefs.setString(
        SharePreferencesKeys.userSettingKey,
        saveString,
      );
      if (!success) {
        throw Exception('Failed to save settings');
      }
    } catch (e) {
      print('Error saving user settings: $e');
      rethrow;
    }
  }
}
