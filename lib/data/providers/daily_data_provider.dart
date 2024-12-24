import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:jt_app_basic_structure/data/models/save/daily_data.dart';
import 'package:jt_app_basic_structure/utils/save/share_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:util_and_style_cores/utils/time_manager.dart';

class DailyDataProvider extends ChangeNotifier {
  DailyData? _todayData;
  DailyData? _previousDayData;

  DailyData? get todayData => _todayData;
  DailyData? get previousDayData => _previousDayData;

  late final Future<void> initializationFuture;
  DailyDataProvider() {
    initializationFuture = initialization();
  }

  Future<void> initialization() async {
    try {
      _todayData = await loadGeneralDailyData();
      checkAndResetGeneralDailyData();
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> saveGeneralDailyData() async {
    try {
      if (_todayData == null) {
        throw Exception("No data to save.");
      }
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String dataJson = json.encode(_todayData!.toJson());
      bool success =
          await prefs.setString(SharePreferencesKeys.dailyDataKey, dataJson);
      if (!success) {
        throw Exception("Failed to save daily data.");
      }
    } catch (e) {
      print("Error saving daily data: $e");
    }
  }

  Future<DailyData> loadGeneralDailyData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? dataJson = prefs.getString(SharePreferencesKeys.dailyDataKey);
      if (dataJson == null) return DailyData();
      return DailyData.fromJson(json.decode(dataJson));
    } catch (e) {
      print("Error loading daily data: $e");
      return DailyData();
    }
  }

  void checkAndResetGeneralDailyData() async {
    if (_todayData == null) {
      print("No data to check and reset.");
      return;
    }
    if (_todayData!.lastCheckInEpochMilliseconds != TimeManager.getEpochDay()) {
      _previousDayData = _todayData;
      await saveGeneralDailyData();
      _todayData = DailyData();
    }
    _todayData!.lastCheckInEpochMilliseconds =
        TimeManager.getEpochMillisecond();
    saveGeneralDailyData();
  }
}
