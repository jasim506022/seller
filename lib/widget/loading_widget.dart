import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seller/res/app_string.dart';
import 'package:seller/res/apps_text_style.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 14),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text("$message \n ${AppStrings.pleaseWaitMessage} ",
              textAlign: TextAlign.center, style: AppsTextStyle.titleText)
        ],
      ),
    );
  }
}
