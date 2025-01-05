import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:jt_app_basic_structure/data/models/ui/navigation_screen.dart';
import 'package:util_and_style_cores/utils/overlay_manager.dart';

class UiControlProvider extends ChangeNotifier {
  UiControlProvider({
    GoRouter? router,
  })  : _currentScreen = NavigationScreen.empty,
        _router = router;

  NavigationScreen _currentScreen;
  NavigationScreen get currentScreen => _currentScreen;

  GoRouter? _router;
  GoRouter? get router => _router;

  BuildContext? _rootContext;
  BuildContext? get rootContext => _rootContext;
  final Map<String, BuildContext> _contextMap = {};

  void setRouter(GoRouter router) {
    _router = router;
  }

  void setRootContext(BuildContext context) {
    _rootContext = context;
  }

  // change screen.
  void changeScreen(NavigationScreen screen) {
    _currentScreen = screen;
    if (_router != null) {
      OverlayManager().removeAllOverlays();
      _router!.go(screen.route);
    }
    notifyListeners();
  }

  void addContext(String key, BuildContext context) {
    _contextMap[key] = context;
  }

  BuildContext? getContext(String key) {
    return _contextMap[key];
  }

  OverlayEntry pushOverlayOnTopOfEverything(Widget overlay,
      {bool builtInSelfRemoval = false,
      Color backgroundColor = const Color.fromARGB(160, 0, 0, 0)}) {
    if (_rootContext == null) {
      throw Exception('Root context is not set');
    }
    return OverlayManager().showOverlay(
        context: _rootContext!,
        overlayContent: overlay,
        backgroundColor: backgroundColor,
        builtInSelfRemoval: builtInSelfRemoval);
  }

  void removeTopOverlay() {
    OverlayManager().removeTopOverlay();
  }

  void removeOverlay(OverlayEntry overlay) {
    OverlayManager().removeOverlay(overlay);
  }
}
