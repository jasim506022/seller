import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'utils.dart';
import '../data/response/app_data_exception.dart';

import '../widget/show_alert_dialog.dart';
import 'apps_color.dart';
import 'apps_text_style.dart';
import 'app_string.dart';

class AppsFunction {
  // IsValidEmail
  static bool isValidEmail(String email) {
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)*[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

// Show Back Dialog
  static Future<bool?> showBackDialog() {
    return Get.dialog(ShowAlertDialog(
      icon: Icons.question_mark_rounded,
      title: AppStrings.exitDialogTitle,
      content: AppStrings.confirmExitMessage,
      onConfirmPressed: () {
        Get.back(result: true);
      },
      onCancelPressed: () {
        Get.back(result: false);
      },
    ));
  }

  /// Provides vertical spacing with adaptive height scaling.
  static SizedBox verticalSpacing(double height) => SizedBox(height: height.h);

  /// Provides horizontal spacing with adaptive width scaling.
  static SizedBox horizontalSpacing(double width) => SizedBox(width: width.w);

  static flutterToast({required String msg}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.red,
        textColor: AppColors.white,
        fontSize: 16.0);
  }

  static InputDecoration inputDecoration({
    required String hint,
  }) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff00B761), width: 1),
          borderRadius: BorderRadius.circular(15)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff00B761), width: 1),
          borderRadius: BorderRadius.circular(15)),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }

  /// This function provides a pre-defined text field decoration with options for:
  static InputDecoration textFieldInputDecoration(
      {bool isShowPassword = false,
      required String hintText,
      bool obscureText = false,
      bool isEnable = true,
      VoidCallback? onPasswordToggle}) {
    // ✅ More specific type}
    return InputDecoration(
        // Background color changes based on enabled state

        fillColor:
            isEnable ? AppColors.searchLightColor : ThemeUtils.textFieldColor,
        filled: true,
        hintText: hintText,
        // Border styling: No border, rounded corners
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15.r)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15.r)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15.r)),
        // Adds password visibility toggle if needed
        suffixIcon: isShowPassword
            ? IconButton(
                onPressed: onPasswordToggle ?? () {}, // ✅ Safe null handling,
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: obscureText ? AppColors.hintLight : AppColors.red,
                ))
            : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        hintStyle: AppsTextStyle.hintText);
  }

  static void handleException(Object e) {
    if (e is FirebaseAuthException) {
      throw FirebaseAuthExceptions(e);
    } else if (e is FirebaseException) {
      throw FirebaseExceptions(e);
    } else if (e is SocketException) {
      throw InternetException(e.toString());
    } else if (e is PlatformException) {
      throw PlatformExceptions(e);
    } else if (e is FileSystemException) {
      throw FileSystemExceptions(e.toString());
    } else if (e is OutOfMemoryError) {
      throw OutOfMemoryErrors(e.toString());
    } else if (e is TimeoutException) {
      throw TimeOutExceptions(e.message.toString());
    } else {
      throw OthersException(e.toString());
    }
  }

  /// Calculates the discounted price of a product based on its original price and discount percentage.
  static double calculateDiscountedPrice(num productPrice, double discount) {
    return productPrice - (productPrice * discount / 100);
  }

  /// Returns the discounted price of a product.
  static double getDiscountedPrice(num productPrice, double discount) {
    return calculateDiscountedPrice(productPrice, discount);
  }

  /// Returns the total price for a given quantity of a product, including discount.
  static double calculateTotalPriceWithQuantity(
      num productPrice, double discount, int quantity) {
    return calculateDiscountedPrice(productPrice, discount) * quantity;
  }

  /// Formats a Unix timestamp (milliseconds since epoch) into a human-readable date string.
  /// - `timestamp`: Accepts an `int` or `String` (milliseconds since epoch).
  /// - `includeTime`: If `true`, returns the date with time (e.g., `10:30 AM, Jan 1, 2024`).
  /// Returns `"N/A"` if the input is invalid.

  static String formatDate(
      {required String timestamp, bool includeTime = true}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    return includeTime
        ? DateFormat('hh:mm a, MMM d, yyyy').format(date)
        : DateFormat("MMM d, yyyy").format(date);
  }

  /// Creates a shimmer effect placeholder for loading states.
  ///
  /// - [height] (required): Height of the shimmer placeholder.
  /// - [width]: Optional width; defaults to full screen width.
  /// - [isCircular]: If `true`, creates a circular shimmer effect.
  static Container shimmerPlaceholder(
      {required double height, double? width, bool isCircle = false}) {
    return Container(
      height: height.h,
      width: isCircle ? height.h : width?.w ?? double.infinity,
      decoration: BoxDecoration(
          color: ThemeUtils.shimmerWidgetColor,
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircle ? null : BorderRadius.circular(15.r)),
    );
  }

  // static String getFormateDate({required String datetime}) {
  //   final date = DateTime.fromMillisecondsSinceEpoch(int.parse(datetime));
  //   return DateFormat("MMM d, yyyy").format(date);
  // }

  /// Sets the system UI overlay style to match the Screen.
  /// Ensures status bar adapts to the current theme dynamically
  static void setSystemUIOverlayStyle(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Theme.of(context).brightness));
  }

  /// Returns a standard grid delegate for displaying products in a 2-column layout.
  /// This maintains consistent spacing and aspect ratio across product grids.
  static SliverGridDelegateWithFixedCrossAxisCount
      defaultProductGridDelegate() {
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: .76,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
    );
  }
}

/*
Function? function and  function!();
Function? function and why use VoidCallback? onPasswordToggle
onPressed: () {
                  function!();
                }, diffewrence 

*/