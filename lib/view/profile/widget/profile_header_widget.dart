import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../res/app_constants.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_text_style.dart';

import '../../../res/routes/routes_name.dart';
import '../../../widget/app_button.dart';
import '../../../widget/user_avatar_widget.dart';

/// A widget that display the user's profile header
///
/// Show profile image, name, email and an "Edit Profile" Button

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /// Fetch user profile data from SharedPreference
    final Map<String, String> userData = _fetchUserProfile();
    return Container(
      height: 153.h,
      width: 1.sw,
      color: Theme.of(context).cardColor,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          // User Profile Avatar
          UserAvatarWidget(
            diameter: 125,
            imageUrl: userData['profileImageUrl']!,

          ),
          AppsFunction.horizontalSpacing(30),

          /// Profile Details (name, email, edit button)
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.w),
              child: _buildUserInfoSection(userData),
            ),
          ),
        ],
      ),
    );
  }

  /// Fetches user profile data from shared preferences.
  /// Ensures that null values are safely handled with defaults.
  Map<String, String> _fetchUserProfile() {
    var sharePreference = AppConstants.sharedPreferences!;
    return {
      'name':
          sharePreference.getString(AppStrings.prefUserName) ??
          AppStrings.defaultName,
      'email':
          sharePreference.getString(AppStrings.prefUserEmail) ??
          AppStrings.defaultEmail,
      'profileImageUrl':
          sharePreference.getString(AppStrings.prefUserProfilePic) ??
          AppStrings.defaultImage,
    };
  }

  /// Builds the user information section with name, email, and an edit profile button.
  Widget _buildUserInfoSection(Map<String, String> userData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          //  user name
          userData['name']!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppsTextStyle.titleText,
        ),
        //  user email
        Text(
          userData['email']!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppsTextStyle.subTitleTextStyle,
        ),
        // Edit Profile button
        AppButton(
          onPressed:
              () => Get.toNamed(RoutesName.editProfilePage, arguments: true),
          title: AppStrings.btnEditProfile,
          width: 160,
        ),
      ],
    );
  }
}

/*
1. When use this:  Localization support using .tr if you're using GetX for internationalization.
 */
