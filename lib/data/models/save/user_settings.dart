class UserSettings {
  bool hasEnteredApp;
  DateTime joinedDate;
  // add other properties as needed.
  // ...

  UserSettings({
    this.hasEnteredApp = false,
    DateTime? joinedDate,
  }) : joinedDate = joinedDate ?? DateTime.now();

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      hasEnteredApp: json['hasEnteredApp'] ?? false,
      joinedDate: json['joinedDate'] != null
          ? DateTime.parse(json['joinedDate'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hasEnteredApp': hasEnteredApp,
      'joinedDate': joinedDate.toIso8601String(),
    };
  }
}
