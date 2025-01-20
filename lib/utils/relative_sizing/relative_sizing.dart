import 'package:flutter/material.dart';
import 'package:jt_app_basic_structure/utils/relative_sizing/models/dimention.dart';

abstract class RelativeSizing {
  static bool relativeSizingEnabled = false;

  static bool _isDisplaySizeTheScreenSize = true;
  static bool get isDisplaySizeTheScreenSize => _isDisplaySizeTheScreenSize;

  static double _displayWidth = 100;
  static double get displayWidth => _displayWidth;

  static double _displayHeight = 100;
  static double get displayHeight => _displayHeight;

  static const double _modelWidthReference = 360;
  static double get modelWidthReference => _modelWidthReference;

  static const double _modelHeightReference = 640;
  static double get modelHeightReference => _modelHeightReference;

  static void setScreenSize({
    required double width,
    required double height,
    bool isDisplaySizeTheScreenSize = true,
  }) {
    _displayWidth = width;
    _displayHeight = height;
    _isDisplaySizeTheScreenSize = isDisplaySizeTheScreenSize;
  }

  static void setRelativeSizingEnabled({required bool enabled}) {
    relativeSizingEnabled = enabled;
  }

  // this can be useful when working with different screen dimensions and aspect ratios
  static bool isRichSpacing({
    required MediaQueryData mediaQueryData,
    bool requiredLandviewMode = true,
    double? minRequiredHeight = 700,
    double? minRequiredWidth = 700,
  }) {
    bool isStillRichSpacing = true;
    if (requiredLandviewMode) {
      if (mediaQueryData.size.aspectRatio < 1) {
        isStillRichSpacing = false;
      }
    }
    if (minRequiredHeight != null) {
      if (mediaQueryData.size.height < minRequiredHeight) {
        isStillRichSpacing = false;
      }
    }
    if (minRequiredWidth != null) {
      if (mediaQueryData.size.width < minRequiredWidth) {
        isStillRichSpacing = false;
      }
    }
    return isStillRichSpacing;
  }

  static double fromPercentage(double percent,
      {Dimension dimension = Dimension.width}) {
    if (dimension == Dimension.width) {
      return (percent / 100) * _displayWidth;
    } else {
      return (percent / 100) * _displayHeight;
    }
  }

  static double fromCommonUnit(double unitSize,
      {Dimension dimension = Dimension.width}) {
    if (!relativeSizingEnabled) {
      return unitSize;
    }
    if (dimension == Dimension.width) {
      return (_displayWidth / _modelWidthReference) * unitSize;
    } else {
      return (_displayHeight / _modelHeightReference) * unitSize;
    }
  }

  /// modelWidthToHeightRatio is the height divided by width
  static double getSuitablePercentageSize(
    double percent, {
    double modelWidthToHeightRatio = 2,
  }) {
    double actualWidthToHeightRatio = _displayHeight / _displayWidth;
    if (actualWidthToHeightRatio < modelWidthToHeightRatio) {
      // is wider, then try to stretch the width
      return fromPercentage(percent, dimension: Dimension.width);
    } else {
      // is taller, then try to stretch the height
      return fromPercentage(percent, dimension: Dimension.height);
    }
  }
}

