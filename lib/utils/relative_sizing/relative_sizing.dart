import 'package:jt_app_basic_structure/utils/relative_sizing/models/dimention.dart';

abstract class RelativeSizing {
  static double screenWidth = 100;
  static double screenHeight = 100;
  static double modelWidthReference = 360;
  static double modelHeightReference = 640;

  static void setScreenSize({
    required double width,
    required double height,
  }) {
    screenWidth = width;
    screenHeight = height;
  }

  static double fromPercentage(double percent,
      {Dimension dimension = Dimension.width}) {
    if (dimension == Dimension.width) {
      return (percent / 100) * screenWidth;
    } else {
      return (percent / 100) * screenHeight;
    }
  }

  static double fromCommonUnit(double unitSize,
      {Dimension dimension = Dimension.width}) {
    if (dimension == Dimension.width) {
      return (screenWidth / modelWidthReference) * unitSize;
    } else {
      return (screenHeight / modelHeightReference) * unitSize;
    }
  }

  /// modelWidthToHeightRatio is the height divided by width
  static double getSuitablePercentageSize(
    double percent, {
    double modelWidthToHeightRatio = 2,
  }) {
    double actualWidthToHeightRatio = screenHeight / screenWidth;
    if (actualWidthToHeightRatio < modelWidthToHeightRatio) {
      // is wider, then try to stretch the width
      return fromPercentage(percent, dimension: Dimension.width);
    } else {
      // is taller, then try to stretch the height
      return fromPercentage(percent, dimension: Dimension.height);
    }
  }
}
