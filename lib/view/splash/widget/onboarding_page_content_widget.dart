import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/onboarding_controller.dart';
import '../../../model/onboard_model.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_text_style.dart';
import 'next_action_button_widget.dart';
import 'onboarding_progress_dots_widget.dart';

/// Displays the content for each onboarding page, including the image, title,
/// description, progress dots, and the 'Next' button.
class OnboardingPageContentWidget extends StatelessWidget {
  const OnboardingPageContentWidget({super.key, required this.onboardModel});

  /// Data model containing onboarding page content.
  final OnboardModel onboardModel;

  @override
  Widget build(BuildContext context) {
    // Get the controller that manages onboarding logic and state
    final OnboardingController onboardingController =
        Get.find<OnboardingController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Onboarding image with responsive height
        Image.asset(onboardModel.image, height: 300.h, fit: BoxFit.fill),

        // Progress indicator dots for onboarding pages
        const OnboardingProgressDotsWidget(),

        // Title of the current onboarding page
        Text(onboardModel.title, style: AppsTextStyle.largeTitle),
        // Description text with centered alignment and extra line height for readability

        Text(
          onboardModel.description,
          textAlign: TextAlign.center,
          style: AppsTextStyle.mediumBoldText.copyWith(height: 2),
        ),

        // Button to proceed to next page or skip onboarding
        NextActionButtonWidget(
          title: AppStrings.btnNext,
          onTap: onboardingController.goToNextPageOrSkip,
        ),
      ],
    );
  }
}
