import 'package:flutter/material.dart';

class SampleScreen extends StatefulWidget {
  const SampleScreen({
    super.key,
  });

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  ScrollController? _scrollController;
  int dailyStepCount = 0;
  // late Future<void> _stepsFuture;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            
          ],
        ),
      ),
      // child: const Center(
      //   child: Text(
      //     'Happy Building Flutter Apps!',
      //     maxLines: 10,
      //     style: TextStyle(
      //       fontSize: 24,
      //       fontWeight: FontWeight.bold,
      //       color: Colors.black54,
      //     ),
      //   ),
      // ),
    );
  }
}
