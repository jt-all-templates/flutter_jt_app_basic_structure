part of '../app_guide_screen.dart';

class _GuideScreenBaseLayout extends StatelessWidget {
  final String? title;
  final String? svgPath;
  final List<Widget> children;
  final String? description;
  const _GuideScreenBaseLayout({
    super.key,
    this.title,
    this.svgPath,
    this.children = const [],
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    double deviceScreenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double maxWidth = constraints.maxWidth;
          return SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.all(FlexSizing.getFitSize(15, deviceScreenWidth)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: constraints.maxHeight * 0.07),
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        title!,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          height: 1.3,
                          color: Color.fromARGB(174, 0, 0, 0),
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  if (svgPath != null)
                    CommonSVGIcon(
                      svgPath: svgPath!,
                      width: maxWidth,
                      height: maxWidth,
                    ),
                  ...children,
                  if (description != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        description!,
                        maxLines: 50,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          height: 1.2,
                          color: ColorUtils.black128a,
                          fontSize: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SelectArea extends StatelessWidget {
  final List<Widget> children;
  const _SelectArea({super.key, this.children = const []});

  @override
  Widget build(BuildContext context) {
    // double deviceScreenHeight = MediaQuery.of(context).size.height;
    double deviceScreenWidth = MediaQuery.of(context).size.width;

    return Container(
      // constraints: BoxConstraints(
      //   maxHeight: deviceScreenHeight * 0.6,
      // ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(FlexSizing.getFitSize(15, deviceScreenWidth)),
      ),
      child: Padding(
        padding: EdgeInsets.all(FlexSizing.getFitSize(5, deviceScreenWidth)),
        child: Column(
          children: children,
        ),
      ),
      // SingleChildScrollView(
      //   child: Padding(
      //     padding: EdgeInsets.all(FlexSizing.getFitSize(10, deviceScreenWidth)),
      //     child: Column(
      //       children: children,
      //     ),
      //   ),
      // ),
    );
  }
}

class _NavigationButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function()? onPressed;
  const _NavigationButton({
    super.key,
    this.title = 'Next',
    this.color = const Color.fromARGB(255, 236, 202, 109),
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double deviceScreenWidth = MediaQuery.of(context).size.width;

    return ButtonPreset(
      normalColor: color,
      onTap: onPressed,
      height: FlexSizing.getFitSize(40, deviceScreenWidth),
      width: FlexSizing.getFitSize(200, deviceScreenWidth),
      boxShadow: [
        CommonBoxShadow(),
      ],
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          title,
          style: const TextStyle(
            color: ColorUtils.black128a,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
