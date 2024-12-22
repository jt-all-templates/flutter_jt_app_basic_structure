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

  // some beginning logics. Try not to let the whole app rely on this.
  Future<void> _initProcess() async {
    UiControlProvider uiProvider = context.read<UiControlProvider>();
    UserSettingProvider userSettingProvider =
        context.read<UserSettingProvider>();
    await userSettingProvider.initializationFuture;
    if (userSettingProvider.userSettings!.hasEnteredApp) {
      uiProvider.changeScreen(NavigationScreen.home);
    } else {
      uiProvider.changeScreen(NavigationScreen.guide);
    }
    FlutterNativeSplash.remove();
    print('App initialized');
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
