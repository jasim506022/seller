import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/response/service/onboarding_list_data.dart';
import '../res/app_constants.dart';
import '../res/app_string.dart';
import '../res/routes/routes_name.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController(initialPage: 0);
  var currentIndex = 0.obs;

  /// Marks the onboarding as viewed in shared preferences and navigates to the sign-in page
Future< void> skipOnboarding() async {
    AppConstants.isViewed = 1;
   await AppConstants.sharedPreference!
        .setInt(AppStrings.prefOnboarding, AppConstants.isViewed);
    Get.offNamed(RoutesName.signInPage);
  }

  /// Navigates to the next page in the onboarding sequence
 Future<void> goToNextPageOrSkip() async {
    if (currentIndex.value ==
        OnBoardingListData.getOnboardingData().length - 1) {
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
