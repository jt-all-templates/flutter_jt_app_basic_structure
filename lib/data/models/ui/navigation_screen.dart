enum NavigationScreen {
  empty,
  guide,
  home;

  String get route {
    switch (this) {
      case NavigationScreen.empty:
        return '/';
      case NavigationScreen.guide:
        return '/guide';
      case NavigationScreen.home:
        return '/home';
    }
  }

  bool showBottomBar() {
    switch (this) {
      case NavigationScreen.empty:
        return false;
      case NavigationScreen.guide:
        return false;
      case NavigationScreen.home:
        return true;
    }
  }
}