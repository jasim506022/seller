import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../res/app_constants.dart';
import '../../res/routes/routes_name.dart';
import '../model/app_exception.dart';
import '../repository/splash_repository.dart';
import '../res/app_asset/icon_asset.dart';
import '../res/app_string.dart';
import '../widget/error_dialog_widget.dart';

/// `SplashController` handles the logic for the splash page, including navigation
/// and UI configuration. It determines whether the user should go to the main page,
/// onboarding, or sign-in page.
class SplashController extends GetxController {
  /// Repository to manage user-related operations.
  SplashRepository repository;

  SplashController({required this.repository});

  @override
  void onInit() {
    // Navigate to the next page based on app logic
    _navigateToNextPage();
    _configureUI();
    super.onInit();
  }

  /// Determines the next page based on user authentication state and onboarding status.
  void _navigateToNextPage() {
    try {
      Future.delayed(
        // Delay for 2 seconds to simulate a splash effect
        const Duration(seconds: 2),
        () {
          User? currentUser = repository.getCurrentUser();

          // If user is logged in, navigate to the main page
          final route =
              currentUser != null
                  ? RoutesName.mainPage
                  : (AppConstants.isOnboardingViewed == false
                      ? RoutesName.onboardingPage
                      : RoutesName.signInPage);
          // Navigate to the determined route and remove splash from history
          Get.offNamed(route);
        },
      );
    } catch (e) {
      if (e is AppException) {
        Get.dialog(
          ErrorDialogWidget(
            icon: AppIcons.warningIconPath,
            title: e.title!,
            content: e.message,
            buttonText: AppStrings.btnOkay,
          ),
        );
      }
    }
  }

  @override
  void onClose() {
    // Restore system UI elements when the splash page is closed
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.onClose();
  }

  /// Configures the UI settings to make the splash page immersive (full page).
  void _configureUI() {
    // Hides the status and navigation bars for an immersive experience
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }
}
