import 'package:flutter/material.dart';
import 'package:jt_app_basic_structure/utils/relative_sizing/relative_sizing.dart';

class _PrivateContainer extends StatelessWidget {
  const _PrivateContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: RelativeSizing.fromCommonUnit(300),
      height: RelativeSizing.fromCommonUnit(200),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(RelativeSizing.fromCommonUnit(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: RelativeSizing.fromCommonUnit(4),
            spreadRadius: 0,
            offset: Offset(0, RelativeSizing.fromCommonUnit(3)),
          ),
        ],
      ),
    );
  }
}
