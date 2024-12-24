class DailyData {
  int lastCheckInEpochMilliseconds;
  // add other properties as needed.
  // ...

  DailyData({
    this.lastCheckInEpochMilliseconds = 0,
  });

  Map<String, dynamic> toJson() => {
        'lastCheckInTime': lastCheckInEpochMilliseconds,
      };

  // Convert a JSON Map to a DailyTaskModel instance.
  static DailyData fromJson(Map<String, dynamic> json) {
    return DailyData(
      lastCheckInEpochMilliseconds: json['lastCheckInTime'],
    );
  }
}
