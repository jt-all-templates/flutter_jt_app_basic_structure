import 'package:flutter/material.dart';
import 'package:jt_app_basic_structure/utils/relative_sizing/models/dimention.dart';
import 'package:jt_app_basic_structure/utils/relative_sizing/relative_sizing.dart';

part 'widgets/full_screen_loading_example.dart';
part 'widgets/grids_example.dart';
part 'widgets/horizontal_scroll_example.dart';
part 'widgets/slider_up_example.dart';
part 'widgets/text_field_example.dart';

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
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildPadding(
                    const Text(
                      'Happy Building Flutter Apps!',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  _buildPadding(
                    const TextFieldExample(),
                  ),
                  _buildPadding(
                    const HorizontalScrollExample(
                      items: [
                        'A short item',
                        'This is a longer item...',
                        'The Last item.',
                      ],
                    ),
                  ),
                  _buildPadding(
                    const GridsExample(),
                  ),
                ],
              ),
            ),
          ),
        ],
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

  Widget _buildPadding(Widget child) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: RelativeSizing.fromCommonUnit(10),
      ),
      child: child,
    );
  }
}
