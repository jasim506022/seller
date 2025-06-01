import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/profile_controller.dart';
import '../../../model/profile_model.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_string.dart';
import '../../loading_widget/loading_profile_header_widget.dart';
import 'user_profile_header.dart';

/// Displays the user's profile header in the home page.
/// Fetches profile data either from shared preferences (cached) or the API (fallback).
class HomeProfileHeaderStream extends StatelessWidget {
  const HomeProfileHeaderStream({super.key});

  @override
  Widget build(BuildContext context) {
    // Attempt to fetch locally cached profile data from shared preferences
    final Map<String, String>? profileData = _fetchLocalProfileData();

    // If local profile data is available, use it directly
    if (profileData != null) {
      return UserProfileHeader(
        imageUrl: profileData['imageUrl']!,
        name: profileData['name']!,
        email: profileData['email']!,
      );
    }

    // If no cached data is found, fetch profile from Database
    return _fetchAndBuildProfile();
  }

  /// Fetches the user profile data from shared preferences.
  /// Returns `null` if no valid data is found.
  Map<String, String>? _fetchLocalProfileData() {
    var sharedPreference = AppConstants.sharedPreferences!;
    final image = sharedPreference.getString(AppStrings.prefUserProfilePic);
    final name = sharedPreference.getString(AppStrings.prefUserName);
    final email = sharedPreference.getString(AppStrings.prefUserEmail);

    // Ensure all values are valid before returning the cached data
    if ([image, name, email].every((data) => data?.isNotEmpty ?? false)) {
      return {'imageUrl': image!, 'name': name!, 'email': email!};
    }
    return null;
  }

  /// Fetches user profile data from API and builds the UI.
  Widget _fetchAndBuildProfile() {
    final ProfileController profileController = Get.find<ProfileController>();
    return FutureBuilder(
      future: profileController.fetchUserProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingProfileHeaderWidget();
        }
        if (snapshot.hasError || snapshot.data == null) {
          return const LoadingProfileHeaderWidget(); // Error fallback
        }

        final Map<String, dynamic>? data = snapshot.data!.data();

        final profileModel = ProfileModel.fromMap(data!);
        // Display the user's profile header with fallback values if any field is null
        return UserProfileHeader(
          imageUrl: profileModel.imageurl ?? AppStrings.defaultImage,
          name: profileModel.name ?? AppStrings.defaultName,
          email: profileModel.email ?? AppStrings.defaultEmail,
        );
      },
    );
  }
}
