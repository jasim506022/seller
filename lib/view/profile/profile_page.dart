import 'package:flutter/material.dart';
import 'package:seller/res/app_function.dart';
import '../../data/response/service/profile_menu_item_list_data.dart';
import '../../res/app_string.dart';
import '../../res/apps_color.dart';
import '../../res/network_utils.dart';
import 'package:get/get.dart';
import '../../controller/profile_controller.dart';
import 'widget/profile_option_tile_widget.dart';
import 'widget/profile_header_widget.dart';
import 'widget/theme_toggle_switch_widget.dart';

/// This Screen display the ** user profile ** section
///
/// it show user details, provide menu option
/// allows theme switching, and includes sign-out action
/// user 'Profile Controller' for managing profile-related actions
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Retrieve the 'Profile Controller' instance using Getx for managing profile data
  late final ProfileController profileController;

  @override
  void initState() {
    super.initState();
    // Initialize the controller after widget creation
    profileController = Get.find<ProfileController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.profileTitle),
        actions: [
          IconButton(
            // Show a placeholder toast message for future settings feature
            onPressed:
                () => AppsFunction.flutterToast(
                  msg: AppStrings.featureComingToast,
                ),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          // Displays profile header with user info
          const ProfileHeaderWidget(),
          Expanded(
            child: ListView(
              children: [
                const Divider(),
                // Generates profile menu options dynamically
                _buildProfileMenuItems(),
                // Allows switching between dark and light themes
                const ThemeToggleSwitchWidget(),
                // Sign-out option with trailing icon hidden
                ProfileMenuItemTileWidget(
                  hasTrailingIcon: false,
                  icon: Icons.exit_to_app,
                  title: AppStrings.signOutLabel,
                  iconColor: AppColors.red,
                  // Handles sign-out action with an internet check
                  onTap:
                      () async => await NetworkUtils.executeWithInternetCheck(
                        action: profileController.signOut,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the list of profile menu items dynamically.
  ///
  /// - Iterates over `ProfileMenuItemListData.profileMenuItems` to generate menu options.
  /// - Navigates to the selected menu item's route.
  Widget _buildProfileMenuItems() {
    return Column(
      children:
          ProfileMenuItemListData.profileMenuItems.map((profileMenuItem) {
            return ProfileMenuItemTileWidget(
              icon: profileMenuItem.icon,
              title: profileMenuItem.title,
              onTap: () async {
                NetworkUtils.executeWithInternetCheck(
                  action: () {
                    if (profileMenuItem.argument is int) {
                      Get.offAndToNamed(
                        profileMenuItem.route,
                        arguments: profileMenuItem.argument,
                      );
                    } else {
                      Get.toNamed(profileMenuItem.route);
                    }
                  },
                );
              },
            );
          }).toList(),
    );
  }
}

/*
1. How print list data on Map;
2.
 */