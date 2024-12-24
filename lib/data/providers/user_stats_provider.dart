import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:jt_app_basic_structure/data/models/save/user_stats.dart';
import 'package:jt_app_basic_structure/utils/save/share_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserStatsProvider extends ChangeNotifier {
  UserStats? _userStats;
  UserStats? get userStats => _userStats;

  int get currency => _userStats?.currency ?? 0;
  int get xp => _userStats?.xp ?? 0;

  late final Future<void> initializationFuture;

  UserStatsProvider() {
    initializationFuture = _initializeStats();
  }

  Future<void> _initializeStats() async {
    try {
      _userStats = await _loadUserStats();
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  void addCurrency(int amount, {bool save = true, bool notify = true}) {
    if (_userStats == null) {
      throw Exception('Stats not initialized');
    }
    _userStats!.currency += amount;
    if (save) {
      saveUserStats();
    }
    if (notify) {
      notifyListeners();
    }
  }

  void addXp(int amount, {bool save = true, bool notify = true}) {
    if (_userStats == null) {
      throw Exception('Stats not initialized');
    }
    _userStats!.xp += amount;
    if (save) {
      saveUserStats();
    }
    if (notify) {
      notifyListeners();
    }
  }

  Future<UserStats> _loadUserStats() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userStatsString =
          prefs.getString(SharePreferencesKeys.userStatsKey);
      if (userStatsString == null) {
        return UserStats();
      }
      Map<String, dynamic> decodedJson = json.decode(userStatsString);
      final stats = UserStats.fromJson(decodedJson);
      return stats;
    } catch (e) {
      print('Error loading user stats: $e');
      return UserStats();
    }
  }

  Future<void> saveUserStats() async {
    if (_userStats == null) {
      throw Exception('Cannot save null stats');
    }
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String saveString = json.encode(_userStats!.toJson());
      final success = await prefs.setString(
        SharePreferencesKeys.userStatsKey,
        saveString,
      );
      if (!success) {
        throw Exception('Failed to save stats');
      }
    } catch (e) {
      print('Error saving user stats: $e');
      rethrow;
    }
  }
}
