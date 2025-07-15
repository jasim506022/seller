import 'package:flutter/material.dart';

import '../../model/profile_model.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';
import '../../res/apps_color.dart';
import '../../res/network_utils.dart';

import '../../res/validator.dart';
import '../../widget/phone_number_widget.dart';
import '../../widget/custom_text_form_field.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/profile_controller.dart';

import 'widget/profile_image_section_widget.dart';

/// **EditProfilePage**
///
/// This screen allows users to **view and edit their profile details**.
/// - Supports **edit mode** based on navigation arguments.
/// - Uses **GetX for state management**.
/// - Fetches user profile data using `ProfileController`.
/// - Provides **form validation** for user inputs.
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Retrieve the 'Profile Controller' instance using Getx for managing profile data
  late final ProfileController profileController;

  // Indicates whether the page is in edit mode.
  late bool isEditMode;

  // Form key for validating form inputs.
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Retrieves whether the page is in **edit mode** based on navigation arguments.
    isEditMode = Get.arguments ?? false;

    // Initialize the controller after widget creation
    profileController = Get.find<ProfileController>();

  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        /// Prevent back navigation while loading.
        if (!profileController.loadingController.loading.value) {
          profileController.handleBackPressed(didPop);
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: ListView(
          children: [
            // Show loading indicator when updating profile.
            Obx(() =>
               profileController.loadingController.loading.value
                  ? const LinearProgressIndicator(
                    backgroundColor: AppColors.red,
                  )
                  : const SizedBox.shrink() // Use this to avoid rendering anything when not loading.
            ),

            // Fetch and display user profile data.
            FutureBuilder(
              future: profileController.fetchUserProfile(applyLocally: false),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text(AppStrings.noDataAvaiableError));
                }

                // **Parse fetched profile data.**
                final profileModel = ProfileModel.fromMap(
                  snapshot.data!.data()!,
                );
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 15.h,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Profile image section, editable if in edit mode.
                        ProfileImageSectionWidget(
                          isEditMode: isEditMode,
                          imageUrl: profileModel.imageurl!,
                        ),
                        AppsFunction.verticalSpacing(50),
                        _buildProfileForm(profileModel),
                        AppsFunction.verticalSpacing(100),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the app bar with a title and save button (only in edit mode).
  AppBar _buildAppBar() {
    return AppBar(
        title: Text(
          isEditMode ? AppStrings.btnEditProfile : AppStrings.aboutTitle,
        ),
        actions: [
          /// Save changes button (only in edit mode).
          if (isEditMode)
            IconButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
                await NetworkUtils.executeWithInternetCheck(
                  action: profileController.updateProfile,
                );
              },
              icon: const Icon(Icons.cloud_upload),
            ),
        ],
      );
  }

  /// **Builds the Profile Form**
  ///
  /// - Includes fields for **name, phone, email, and address**.
  /// - Uses `CustomTextFormField` for text inputs.
  /// - Uses `PhoneNumberWidget` for phone input.
  /// - Validates inputs before submission.
  _buildProfileForm(ProfileModel profileModel) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Name input field
          CustomTextFormField(
            label: AppStrings.nameLabel,
            onChanged:
                (_) => profileController.addChangeListener(profileModel),
            validator: Validators.validateName,
            controller: profileController.nameController,
            hintText: AppStrings.nameHint,
            enabled: isEditMode,
          ),

          /// Phone input field
          PhoneNumberWidget(
            enabled: isEditMode,
            controller: profileController.phoneController,
          ),

          /// **Email Field (Non-Editable)**
          CustomTextFormField(
            label: AppStrings.emailLabel,
            controller: profileController.emailController,
            enabled: false,
            hintText: AppStrings.emailHint,
          ),

          /// Address input field
          CustomTextFormField(
            label: AppStrings.addressLabel,
            validator: Validators.validateAddress,
            onChanged:
                (_) => profileController.addChangeListener(profileModel),
            hintText: AppStrings.addressHint,
            controller: profileController.addressController,
            enabled: isEditMode,
          ),
        ],
      ),
    );
  }
}

/*
final args = Get.arguments;
  isEditMode = args is bool ? args : false;


 */

