part of '../app_guide_screen.dart';

class _LetsGoScreen extends StatelessWidget {
  const _LetsGoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _GuideScreenBaseLayout(
      title: "Are you ready to say 'Hi' to the world?",
      children: [
        // LayoutBuilder(
        //   builder: (BuildContext context, BoxConstraints constraints) {
        //     // double deviceScreenWidth = MediaQuery.of(context).size.width;
        //     return CommonSVGIcon(
        //       svgPath: "",
        //       width: constraints.maxWidth,
        //       height: constraints.maxWidth,
        //     );
        //   },
        // ),
      ],
    );
  }
}
