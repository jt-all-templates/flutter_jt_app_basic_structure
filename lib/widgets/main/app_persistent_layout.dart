import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jt_app_basic_structure/data/models/ui/navigation_screen.dart';
import 'package:jt_app_basic_structure/data/providers/daily_data_provider.dart';
import 'package:jt_app_basic_structure/data/providers/ui/ui_control_provider.dart';
import 'package:jt_app_basic_structure/data/providers/user_profile_provider.dart';
import 'package:jt_app_basic_structure/data/providers/user_stats_provider.dart';
import 'package:jt_app_basic_structure/screens/guide_screen/app_guide_screen.dart';
import 'package:jt_app_basic_structure/screens/sample_screen/sample_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:util_and_style_cores/common/empty_white_screen.dart';
import 'package:util_and_style_cores/structure/useful_scroll_behavior.dart';
import 'package:util_and_style_cores/utils/global_overlay_manager.dart';
import 'package:util_and_style_cores/utils/size_utils/widgets/size_utils_initialization_basic.dart';

part 'widgets/global_overlay_layouter.dart';
part 'widgets/app_initialization_widget.dart';
part 'router/global_router.dart';

class AppPersistentLayout extends StatelessWidget {
  const AppPersistentLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'change this',
      scrollBehavior: MergedScrollBehavior(),
      debugShowCheckedModeBanner: false,
      routerConfig: GlobalRouter.router,
      theme: ThemeData(
        platform: TargetPlatform.android,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: (context, child) {
        return _AppInitializationWidget(
          child: SizeUtilsInitializationBasic(
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
  }
}
