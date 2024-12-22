import 'package:flutter/material.dart';
import 'package:jt_app_basic_structure/utils/relative_sizing/relative_sizing.dart';

class RelativeSizeInitialization extends StatelessWidget {
  final Widget child;
  const RelativeSizeInitialization({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    RelativeSizing.setScreenSize(width: screenWidth, height: screenHeight);
    return child;
  }
}
