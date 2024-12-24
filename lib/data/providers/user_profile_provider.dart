import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:jt_app_basic_structure/data/models/save/user_profile.dart';
import 'package:jt_app_basic_structure/utils/save/share_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileProvider extends ChangeNotifier {
  UserProfiles? _userProfile;
  UserProfiles? get userProfile => _userProfile;

  late final Future<void> initializationFuture;

  UserProfileProvider() {
    initializationFuture = _initializeProfile();
  }

  Future<void> _initializeProfile() async {
    try {
      _userProfile = await _loadUserProfile();
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<UserProfiles> _loadUserProfile() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userProfileString =
          prefs.getString(SharePreferencesKeys.userProfileKey);
      if (userProfileString == null) {
        return UserProfiles();
      }
      Map<String, dynamic> decodedJson = json.decode(userProfileString);
      final UserProfiles profile = UserProfiles.fromJson(decodedJson);
      return profile;
    } catch (e) {
      print('Error loading user profile: $e');
      return UserProfiles();
    }
  }

  Future<void> saveUserProfile() async {
    if (_userProfile == null) {
      throw Exception('Cannot save null profile');
    }
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String saveString = json.encode(_userProfile!.toJson());
      final success = await prefs.setString(
        SharePreferencesKeys.userProfileKey,
        saveString,
      );
      if (!success) {
        throw Exception('Failed to save profile');
      }
    } catch (e) {
      print('Error saving user profile: $e');
      rethrow;
    }
  }
}
