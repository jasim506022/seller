import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_string.dart';
import 'apps_color.dart';

/// A utility class for checking network connectivity and handling no-internet scenarios.
class NetworkUtils {
  static final Connectivity _connectivity = Connectivity();

  /// Executes the given [action] only if the device has an active internet connection.
  ///
  /// If there is no internet, shows a snackbar. Optionally, [onNoInternet] can be provided
  /// to handle the failure case manually.
  // static Future<void> executeWithInternetCheck({
  //   required VoidCallback action,
  // }) async {
  //   if (await _hasInternet()) {
  //     action();
  //   } else {
  //     _showNoInternetSnackbar();
  //   }
  // }

  static Future<void> executeWithInternetCheck({
    required VoidCallback action,
    VoidCallback? onNoInternet,
  }) async {
    final isConnected = await _isConnectedToInternet();
    if (isConnected) {
      action();
    } else {
      if (onNoInternet != null) {
        onNoInternet();
      } else {
        _showNoInternetSnackbar();
      }
    }
  }

  // /// Checks if the device has an active internet connection.
  // static Future<bool> _hasInternet() async {
  //   return await _connectivity.checkConnectivity() != ConnectivityResult.none;
  // }

  /// Checks whether the device is connected to the internet.
  static Future<bool> _isConnectedToInternet() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  /// Displays a snackbar when there is no internet.
  static void _showNoInternetSnackbar() {
    Get.snackbar(
      AppStrings.noInternet,
      AppStrings.noInternetMessage,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.black.withOpacity(.7),
      colorText: AppColors.white,
      duration: const Duration(seconds: 1),
      margin: EdgeInsets.zero,
      borderRadius: 0,
    );
  }
}

/*
2️⃣ Improve executeWithInternetCheck()
✅ Issue: VoidCallback action does not support async functions (like API calls).
✅ Fix: Use Future<void> Function() instead of VoidCallback.
*  Why here need action ();
* Understand It Clear .. Why need !isConnection
*/