part of '../app_guide_screen.dart';

class _WelcomeScreen extends StatelessWidget {
  const _WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _GuideScreenBaseLayout(
      title: "Hi!",
      children: [
        // below is an example of how to use CommonSVGIcon and drop shadow, to create a nice and cozy welcome screen
        // LayoutBuilder(
        //   builder: (BuildContext context, BoxConstraints constraints) {
        //     return Stack(
        //       alignment: Alignment.topCenter,
        //       children: [
        //         Container(
        //           width: constraints.maxWidth * 0.8,
        //           height: constraints.maxWidth * 0.8,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(
        //               999999,
        //             ),
        //             boxShadow: [
        //               BoxShadow(
        //                 color: const Color.fromARGB(255, 164, 231, 88)
        //                     .withOpacity(0.4),
        //                 blurRadius: constraints.maxWidth * 0.6,
        //               )
        //             ],
        //           ),
        //         ),
        //         Column(
        //           children: [
        //             SizedBox(height: constraints.maxWidth * 0.1),
        //             CommonSVGIcon(
        //               svgPath: "",
        //               width: constraints.maxWidth * 0.8,
        //               height: constraints.maxWidth * 0.8,
        //             ),
        //           ],
        //         ),
        //       ],
        //     );
        //   },
        // ),
      ],
    );
  }
}
