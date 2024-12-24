import 'package:flutter/material.dart';
import 'package:jt_app_basic_structure/data/providers/ui/ui_control_provider.dart';
import 'package:jt_app_basic_structure/data/providers/user_profile_provider.dart';
import 'package:jt_app_basic_structure/screens/guide_screen/data/providers/guide_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:util_and_style_cores/style/animated/consistent/wiggling_effect.dart';
import 'package:util_and_style_cores/style/buttons/presets/button_preset.dart';
import 'package:util_and_style_cores/style/svg/common_svg_icon.dart';
import 'package:util_and_style_cores/themes/common_styles.dart';
import 'package:util_and_style_cores/utils/color_utils.dart';
import 'package:util_and_style_cores/utils/flex_sizing.dart';

part 'widgets/guide_screen_widgets.dart';
part 'screens/welcome_screen.dart';
part 'screens/lets_go_screen.dart';

class AppGuideScreen extends StatefulWidget {
  const AppGuideScreen({super.key});

  @override
  State<AppGuideScreen> createState() => _AppGuideScreenState();
}

class _AppGuideScreenState extends State<AppGuideScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  final String exitButtonText = "Let's go!";
  final int totalPages = 2;
  final List<Color> _backgroundColors = [
    Colors.white,
    Colors.white,
  ];
  Color _currentBackgroundColor = Colors.white;
  bool _isFinalPage = false;

  @override
  void initState() {
    super.initState();
    _currentBackgroundColor = _backgroundColors[0];

    _pageController.addListener(() {
      setState(() {
        _currentBackgroundColor =
            _getBackgroundColor(_pageController.page ?? 0.0);
        if (_pageController.page?.round() == totalPages - 1) {
          _isFinalPage = true;
        } else {
          _isFinalPage = false;
        }
      });
    });
  }

  Color _getBackgroundColor(double page) {
    int lowerIndex = page.floor();
    int upperIndex = page.ceil();
    double t = page - lowerIndex;

    if (lowerIndex >= _backgroundColors.length - 1) {
      return _backgroundColors.last;
    }

    return Color.lerp(
            _backgroundColors[lowerIndex], _backgroundColors[upperIndex], t) ??
        _backgroundColors[lowerIndex];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceScreenWidth = MediaQuery.of(context).size.width;
    double dotSize = FlexSizing.getFitSize(14, deviceScreenWidth);

    // when update this, also update _totalPages and _backgroundColors
    List<Widget> pages = [
      _buildPage(const _WelcomeScreen()),
      _buildPage(const _LetsGoScreen()),
    ];

    return ChangeNotifierProvider(
      create: (context) => GuideScreenProvider(
        // GuideScreenProvider don't consume any value from these providers, so no need to listen to them
        uiControlProvider: context.read<UiControlProvider>(),
        userProfileProvider: context.read<UserProfileProvider>(),
      ),
      child: Consumer<GuideScreenProvider>(
        builder: (context, guideScreenProvider, child) {
          guideScreenProvider.pageController = _pageController;
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: _currentBackgroundColor,
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      children: pages,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: FlexSizing.getFitSize(
                          MediaQuery.of(context).size.height * 0.02,
                          deviceScreenWidth),
                      top: FlexSizing.getFitSize(
                          MediaQuery.of(context).size.height * 0.01,
                          deviceScreenWidth),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        (_isFinalPage)
                            ? WigglingEffect(
                                child: _NavigationButton(
                                  title: exitButtonText,
                                  onPressed: () {
                                    guideScreenProvider.onGuideCompleted();
                                  },
                                ),
                              )
                            : _NavigationButton(
                                onPressed: () {
                                  guideScreenProvider.moveToNextPage();
                                },
                              ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.012),
                        SmoothPageIndicator(
                          controller: _pageController,
                          count: totalPages,
                          axisDirection: Axis.horizontal,
                          effect: JumpingDotEffect(
                            // SlideEffect
                            // WormEffect
                            spacing: dotSize * 1.4,
                            radius: dotSize / 2,
                            dotWidth: dotSize,
                            dotHeight: dotSize,
                            paintStyle: PaintingStyle.fill,
                            strokeWidth: 0,
                            dotColor: ColorUtils.black32a,
                            activeDotColor:
                                guideScreenProvider.colorPalette.secondaryColor,
                          ),
                        ),
                      ],
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

  Widget _buildPage(Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: child),
      ],
    );
  }
}
