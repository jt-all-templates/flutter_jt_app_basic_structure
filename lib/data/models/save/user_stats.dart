/// Is used to store numerical values that represent the user's progress in the app/game.
class UserStats {
  int currency;
  int xp;
  // add other properties as needed.
  // ...

  UserStats({
    this.currency = 0,
    this.xp = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'currency': currency,
      'xp': xp,
    };
  }

  static UserStats fromJson(Map<String, dynamic> json) {
    return UserStats(
      currency: json['currency'],
      xp: json['xp'],
    );
  }
}
