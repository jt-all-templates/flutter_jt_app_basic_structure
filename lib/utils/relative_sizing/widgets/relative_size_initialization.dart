import 'package:flutter/material.dart';
import 'package:jt_app_basic_structure/utils/relative_sizing/relative_sizing.dart';

class RelativeSizeInitialization extends StatelessWidget {
  final Widget child;
  const RelativeSizeInitialization({super.key, required this.child});

  void _basicUpdateScreenSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    RelativeSizing.setScreenSize(width: screenWidth, height: screenHeight);
    RelativeSizing.setRelativeSizingEnabled(enabled: true);
  }

  /* 
  // Here are examples of how you can update the screen size based on the requirement of the app.

  void _noRelativeSizingUpdateScreenSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    RelativeSizing.setScreenSize(width: screenWidth, height: screenHeight);
     // disable relative sizing for the app-wide.
    RelativeSizing.setRelativeSizingEnabled(enabled: false);
  }

  void _portraitFocusedAppUpdateScreenSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double aspectRatio = MediaQuery.of(context).size.aspectRatio;

    if (aspectRatio < 0.6) {
      // this is all good. in a normal mobile app' portrait condition.
      RelativeSizing.setRelativeSizingEnabled(enabled: true);
      RelativeSizing.setScreenSize(width: screenWidth, height: screenHeight);
    } else {
      // not "portrait" enough, or its landscape mode. Since landscape mode is not enabled in mobile, this is likely a web condition or desktop condition.
      RelativeSizing.setRelativeSizingEnabled(enabled: false);
      double displayWidth = screenHeight * 0.6; // 60% of the height
      RelativeSizing.setScreenSize(
        width: displayWidth,
        height: screenHeight,
        isDisplaySizeTheScreenSize: false,
      );
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    _basicUpdateScreenSize(context);
    return child;
  }
}
