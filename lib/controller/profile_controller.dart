import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../model/app_exception.dart';
import '../model/profile_model.dart';
import '../repository/auth_repository.dart';
import '../repository/profile_repository.dart';
import '../repository/select_image_repository.dart';
import '../res/app_asset/icon_asset.dart';
import '../res/app_constants.dart';
import '../res/app_function.dart';
import '../res/app_string.dart';
import '../res/routes/routes_name.dart';
import '../widget/error_dialog_widget.dart';
import '../widget/app_alert_dialog.dart';
import 'loading_controller.dart';
import 'select_image_controller.dart';

/// **ProfileController**
///
/// Handles user profile operations:
/// - Fetching/updating profile data.
/// - Managing text fields and UI state.
/// - Handling authentication and sign-out.
/// - Managing Firebase Cloud Messaging (FCM) token
class ProfileController extends GetxController {
  // Dependencies
  final ProfileRepository repository;
  final AuthRepository authRepository = Get.find<AuthRepository>();
  final LoadingController loadingController = Get.find<LoadingController>();
  final SelectImageController imageController =
      Get.find<SelectImageController>();

  // Reactive variables for profile data and UI state
  final RxBool isDataChanged = false.obs;
  final RxString profileImage = "".obs;

  // TextEditingControllers for profile fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Constructor with required repository
  ProfileController({required this.repository});

  @override
  void onClose() {
    // Dispose of all text controllers to prevent memory leaks
    for (final controller in [
      nameController,
      addressController,
      phoneController,
      emailController,
    ]) {
      controller.dispose();
    }
    // Reset observables to their initial states
    isDataChanged(false);
    profileImage.value = "";
    super.onClose();
  }

  /// Updates the user profile information in Firestore.
  ///
  /// Validates the phone number, uploads a new profile image if selected,
  /// updates the profile data in the database, and handles loading state.
  /// Shows feedback to the user and navigates to the main page upon success.
  Future<void> updateProfile() async {
    if (phoneController.text.trim().isEmpty) {
      AppsFunction.flutterToast(msg: AppStrings.phoneNumberPromptMessageToast);
      return;
    }

    try {
      loadingController.setLoading(true);

      // Upload new profile image if selected
      final selectedPhoto = imageController.selectPhoto.value;
      if (selectedPhoto != null) {
        profileImage.value = await authRepository.uploadUserImage(
          file: selectedPhoto,
          isProfile: true,
        );
      }

      // Update user profile in database
      await repository.updateProfile(
        profileData: _buildProfileModel().toMapProfileEdit(),
      );
      // Navigate and notify
      Get.offAllNamed(RoutesName.mainPage, arguments: 3);
      AppsFunction.flutterToast(msg: AppStrings.profileUpdateToast);
    } catch (e) {
      _handleError(e);
    } finally {
      loadingController.setLoading(false);
    }
  }

  /// Creates a ProfileModel instance with trimmed values from text controllers and profile image.
  ///
  ProfileModel _buildProfileModel() {
    return ProfileModel(
      address: addressController.text.trim(),
      phone: phoneController.text.trim(),
      name: nameController.text.trim(),
      imageurl: profileImage.value,
    );
  }

  /// **Adds listeners to detect profile field changes.**
  void addChangeListener(ProfileModel profile) {
    final controllers = [nameController, phoneController, addressController];

    for (var textField in controllers) {
      textField.addListener(() {
        isDataChanged.value = _isProfileChanged(profile);
      });
    }
  }

  /// **Checks if the profile has been modified.**
  bool _isProfileChanged(ProfileModel profile) {
    return nameController.text.trim() != profile.name ||
        phoneController.text.trim() != profile.phone ||
        addressController.text.trim() != profile.address;
  }

  /// Fetches the user profile from Firestore and optionally updates local state.
  ///
  /// If [applyLocally] is true and the user's status is approved,
  /// it stores the profile locally, populates form fields, and updates the FCM token.
  ///
  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserProfile({
    bool applyLocally = true,
  }) async {
    try {
      var userSnapshot = await repository.fetchUserProfile();

      if (!applyLocally) return userSnapshot;
        // Ensure snapshot contains data before proceeding
        var data = userSnapshot.data()!;

        // Convert Firestore data into `ProfileModel`
        var profile = ProfileModel.fromMap(data);

        // Only proceed if user status is **approved**.
        if (profile.status == AppStrings.approved) {
          await _storeProfileLocally(profile);
          _populateTextFields(profile);

          // Update Firebase Cloud Messaging (FCM) token
          var token = await _fetchFCMToken();
          await repository.updateProfile(profileData: {"token": token});
      }
        else{

        }

      return userSnapshot;
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// Stores the user's profile data locally using SharedPreferences.
  ///
  /// Saves fields such as UID, email, name, image URL, phone, and earnings.
  /// Uses [Future.wait] to execute all preference writes concurrently.
  Future<void> _storeProfileLocally(ProfileModel profileModel) async {
    final prefs = AppConstants.sharedPreferences;

    final prefsTasks = [
      prefs!.setString(AppStrings.prefUserId, profileModel.uid!),
      prefs.setString(AppStrings.prefUserEmail, profileModel.email!),
      prefs.setString(AppStrings.prefUserName, profileModel.name!),
      prefs.setString(AppStrings.prefUserProfilePic, profileModel.imageurl!),
      prefs.setString(AppStrings.prefUserPhone, profileModel.phone!),
      prefs.setDouble(
        AppStrings.prefUserEarnings,
        profileModel.earnings!.toDouble(),
      ),
    ];

    await Future.wait(prefsTasks);
  }

  /// Populates UI input fields with values from the given [ProfileModel].
  ///
  /// Sets the text of name, address, phone, and email controllers.
  void _populateTextFields(ProfileModel profileModel) {
    nameController.text = profileModel.name ?? '';
    addressController.text = profileModel.address ?? '';
    phoneController.text = profileModel.phone ?? '';
    emailController.text = profileModel.email ?? '';
    profileImage.value = profileModel.imageurl ?? '';
  }

  /// **Handles back navigation, prompting to save changes if necessary.**
  ///
  Future<void> handleBackPressed(bool alreadyPopped) async {
    if (alreadyPopped) return;

    if (!isDataChanged.value) {
      Get.back();
      return;
    }
    Get.dialog(
      AppAlertDialog(
        icon: Icons.question_mark_rounded,
        title: AppStrings.saveChangesTitle,
        content: AppStrings.saveMessage,
        onCancelPressed: () {
          Get.close(2);
          resetInputs();
        },
        onConfirmPressed: () => Get.back(),
      ),
    );
  }

  /// **Resets input fields and profile image selection.*
  ///
  void resetInputs() {
    // Clear all text controllers
    final controllers = [
      nameController,
      phoneController,
      emailController,
      addressController,
    ];

    for (final controller in controllers) {
      controller.clear();
      ; // Why not use  controller.text = ''
    }
    // Reset selected image
    imageController.selectPhoto.value = null;
    // Reset data change flag
    isDataChanged.value = false;
  }

  /// **Fetches Firebase Cloud Messaging (FCM) token.**
  Future<String?> _fetchFCMToken() async {
    try {
      // Request permission for iOS devices
      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission();
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // Retrieve the token
        String? token = await FirebaseMessaging.instance.getToken();
        return token;
      } else {
        AppsFunction.flutterToast(msg: AppStrings.permissionDeniedToast);
      }
    } catch (e) {
      AppsFunction.flutterToast(msg: "${AppStrings.fcmTokenErrorToast} $e");
    }
    return null;
  }

  /// Handles exceptions by showing a dialog.
  void _handleError(Object error) {
    if (error is AppException) {
      Get.dialog(
        ErrorDialogWidget(
          icon: AppIcons.warningIconPath,
          title: error.title!,
          content: error.message,
          buttonText: AppStrings.btnOkay,
        ),
      );
    }
  }

  /// Displays a confirmation dialog asking the user if they want to exit the app.
  /// If the user confirms, the app will be closed.
  Future<void> exitApp(bool didPop) async {
    // If the app screen was already popped, do nothing.
    if (didPop) return;

    final bool shouldPop =
        await Get.dialog<bool>(
          AppAlertDialog(
            icon: Icons.question_mark_rounded,
            title: AppStrings.exitDialogTitle,
            content: AppStrings.confirmExitMessage,
            onConfirmPressed: () => Get.back(result: true),
            onCancelPressed: () => Get.back(result: false),
          ),
        ) ??
        false;
    // Exit the app if the user confirmed.
    if (shouldPop) SystemNavigator.pop();
  }

  /// Handles user sign-out with a confirmation dialog.
  ///
  /// Clears user-related data from shared preferences,
  /// resets the token on the server, signs the user out,
  /// disposes of related controllers and repositories,
  /// and redirects to the Sign In page.
  Future<void> signOut() async {
    await Get.dialog(
      AppAlertDialog(
        icon: Icons.delete,
        title: AppStrings.signOutLabel,
        content: AppStrings.doYouwantSignoutMessage,
        onConfirmPressed: () async {
          try {
            // Clear user data from shared preferences
            final prefs = AppConstants.sharedPreferences!;
            await prefs.setString(AppStrings.prefUserProfilePic, "");
            await prefs.setString(AppStrings.prefUserName, "");
            await prefs.setString(AppStrings.prefUserEmail, "");
            // Remove token from backend (if used for push notifications)
            await repository.updateProfile(profileData: {"token": ""});
            // Perform sign out from Firebase/Auth service
            await authRepository.signOut();

            // Dispose associated controllers and repositories
            Get.delete<SelectImageController>();
            Get.delete<SelectImageRepository>();

            // Show success toast and navigate to sign-in screen
            AppsFunction.flutterToast(
              msg: AppStrings.successfullySignedOutToast,
            );
            Get.offAllNamed(RoutesName.signInPage);
          } catch (e) {
            AppsFunction.handleException(e);
          }
        },
      ),
    );
  }
}

/*
controller.text = ''; // Use `text = ''` instead of `clear()`
Why Use controller.text = '' Instead of .clear()?
Better performance: .clear() internally calls notifyListeners(), which can cause unnecessary UI rebuilds.
More predictable: Directly setting .text = '' ensures that changes happen without side effects.
#: What is memoery Leak
/// Dispose text controllers to prevent memory leaks.
#: ()
how double to num
#: Why use Final (already)
#:     [nameController, addressController, phoneController, emailController].forEach((c) => c.dispose());

2.
if (!isDataChanged.value) {
      Get.back();
      return;
    } Understand this code
    3. 	Fix unclosed /** style to proper triple slash ///
4. why use final why not use var " final controller"
5. Change	Why
final used instead of var	Prefer final when value won’t change → improves immutability and clarity.
6. Understand Token
*/
 */
