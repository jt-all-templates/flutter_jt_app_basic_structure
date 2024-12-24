import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jt_app_basic_structure/data/models/save/daily_data.dart';
import 'package:jt_app_basic_structure/data/models/ui/navigation_screen.dart';
import 'package:jt_app_basic_structure/data/providers/daily_data_provider.dart';
import 'package:jt_app_basic_structure/data/providers/ui/ui_control_provider.dart';
import 'package:jt_app_basic_structure/data/providers/user_setting_provider.dart';
import 'package:jt_app_basic_structure/data/providers/user_stats_provider.dart';
import 'package:jt_app_basic_structure/screens/sample_screen/sample_screen.dart';
import 'package:jt_app_basic_structure/utils/relative_sizing/widgets/relative_size_initialization.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:util_and_style_cores/utils/global_overlay_manager.dart';

part 'widgets/global_overlay_layouter.dart';
part 'widgets/app_initialization_widget.dart';
part 'router/global_router.dart';

class AppPersistentLayout extends StatelessWidget {
  AppPersistentLayout({super.key});
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<UiControlProvider>(
      builder: (context, uiControlProvider, child) {
        uiControlProvider.setRouter(GlobalRouter.router);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: GlobalRouter.router,
          theme: ThemeData(
            platform: TargetPlatform.android,
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          builder: (context, child) {
            return _AppInitializationWidget(
              child: RelativeSizeInitialization(
                child: Material(
                  type: MaterialType.transparency,
                  child: _GlobalOverlayLayouter(
                    // bottomBar: Container(),
                    content: child, // can use a scaffold here
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
