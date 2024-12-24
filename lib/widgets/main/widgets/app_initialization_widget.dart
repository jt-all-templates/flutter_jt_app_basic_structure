part of '../app_persistent_layout.dart';

class _AppInitializationWidget extends StatefulWidget {
  final Widget child;
  const _AppInitializationWidget({super.key, required this.child});

  @override
  State<_AppInitializationWidget> createState() =>
      _AppInitializationWidgetState();
}

class _AppInitializationWidgetState extends State<_AppInitializationWidget> {
  @override
  void initState() {
    super.initState();
    _initProcess();
  }

  // some beginning logics before consuming any data or landing on any screen
  Future<void> _initProcess() async {
    UserProfileProvider userProfileProvider = context.read<UserProfileProvider>();
    UserStatsProvider userStatsProvider = context.read<UserStatsProvider>();
    DailyDataProvider dailyDataProvider = context.read<DailyDataProvider>();

    await userProfileProvider.initializationFuture;
    await userStatsProvider.initializationFuture;
    await dailyDataProvider.initializationFuture;

    _goToCorrectLandingScreen();
    FlutterNativeSplash.remove();
    print('App initialized');
  }

  void _goToCorrectLandingScreen() {
    UiControlProvider uiProvider = context.read<UiControlProvider>();
    if (context.read<UserProfileProvider>().userProfile!.hasEnteredApp) {
      uiProvider.changeScreen(NavigationScreen.home);
    } else {
      uiProvider.changeScreen(NavigationScreen.guide);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UiControlProvider>(
      builder: (context, uiControlProvider, child) {
        uiControlProvider.setRouter(GlobalRouter.router);
        return widget.child;
      },
    );
  }
}
