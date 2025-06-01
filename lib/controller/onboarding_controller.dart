import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/response/service/onboarding_list_data.dart';
import '../res/app_constants.dart';
import '../res/app_string.dart';
import '../res/routes/routes_name.dart';

class OnboardingController extends GetxController {
  /// Controls the onboarding page view
  final PageController pageController = PageController(initialPage: 0);

  /// Observable to track the current onboarding page index
  var currentIndex = 0.obs;

  /// Marks onboarding as completed and navigates to the SignIn page
  Future<void> skipOnboarding() async {
    AppConstants.isOnboardingViewed = true;
    await AppConstants.sharedPreferences!.setBool(
      AppStrings.onboardingViewedKey,
      AppConstants.isOnboardingViewed,
    );
    Get.offNamed(RoutesName.signInPage);
  }

  /// Moves to next onboarding page or skips if on the last page
  Future<void> goToNextPageOrSkip() async {
    if (currentIndex.value == OnBoardingListData.getOnboardingData.length - 1) {
      await skipOnboarding();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
