import 'package:flutter/material.dart';
import 'package:util_and_style_cores/utils/size_utils/size_utils.dart';

class _PrivateContainer extends StatelessWidget {
  const _PrivateContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeUtils.fromCommonUnit(300),
      height: SizeUtils.fromCommonUnit(200),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(SizeUtils.fromCommonUnit(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: SizeUtils.fromCommonUnit(4),
            spreadRadius: 0,
            offset: Offset(0, SizeUtils.fromCommonUnit(3)),
          ),
        ],
      ),
    );
  }
}
