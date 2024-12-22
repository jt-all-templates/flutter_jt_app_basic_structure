import 'package:flutter/material.dart';

class EmptyWhiteScreen extends StatelessWidget {
  const EmptyWhiteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
