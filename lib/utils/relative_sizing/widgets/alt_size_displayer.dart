import 'package:flutter/material.dart';
import 'package:jt_app_basic_structure/utils/relative_sizing/relative_sizing.dart';

class AltSizeDisplayer extends StatelessWidget {
  const AltSizeDisplayer({
    super.key,
    required this.child,
    this.backgroundColor = Colors.transparent,
  });
  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: backgroundColor,
      child: Center(
        child: SizedBox(
          width: RelativeSizing.displayWidth,
          height: RelativeSizing.displayHeight,
          child: child,
        ),
      ),
    );
  }
}
