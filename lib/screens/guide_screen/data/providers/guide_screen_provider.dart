import 'package:flutter/material.dart';
import 'package:jt_app_basic_structure/data/models/ui/navigation_screen.dart';
import 'package:jt_app_basic_structure/data/providers/ui/ui_control_provider.dart';
import 'package:jt_app_basic_structure/data/providers/user_profile_provider.dart';
import 'package:util_and_style_cores/models/color_palette.dart';
import 'package:util_and_style_cores/utils/color_utils.dart';

class GuideScreenProvider extends ChangeNotifier {
  final UiControlProvider uiControlProvider;
  final UserProfileProvider userProfileProvider;
  final Duration _animationDuration = const Duration(milliseconds: 350);
  final TextStyle descriptionTextStyle = const TextStyle(
    height: 1.2,
    color: ColorUtils.black128a,
    fontSize: 20,
  );
  final TextStyle smallDescriptionTextStyle = const TextStyle(
    height: 1.2,
    color: ColorUtils.black104a,
    fontSize: 16,
  );
  final SimpleColorPalette colorPalette = const SimpleColorPalette(
    primaryColor: Color.fromARGB(255, 236, 202, 109),
    secondaryColor: Color.fromARGB(255, 216, 198, 148),
    tertiaryColor: Color.fromARGB(255, 205, 236, 248),
  );
  PageController? pageController;

  GuideScreenProvider({
    required this.uiControlProvider,
    required this.userProfileProvider,
  });

  void moveToNextPage() {
    if (pageController?.page == 3) {
      // Navigator.of(context).pop();
    } else {
      pageController?.nextPage(
        duration: _animationDuration,
        curve: Curves.easeInOut,
      );
    }
  }

  void moveToPreviousPage() {
    if (pageController?.page == 0) {
      // Navigator.of(context).pop();
    } else {
      pageController?.previousPage(
        duration: _animationDuration,
        curve: Curves.easeInOut,
      );
    }
  }

  void goToPage(int page) {
    pageController?.animateToPage(
      page,
      duration: _animationDuration,
      curve: Curves.easeInOut,
    );
  }

  void onGuideCompleted() async {
    // Set hasEnteredApp flag
    userProfileProvider.firstEnterTheApp();
    uiControlProvider.changeScreen(NavigationScreen.home);
  }
}
