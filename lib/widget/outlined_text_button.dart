import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/apps_text_style.dart';

class OutlinedTextButton extends StatelessWidget {
  const OutlinedTextButton({
    super.key,
    required this.onPressed,
    required this.color,
    required this.title,
  });

  final VoidCallback onPressed;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            side: BorderSide(
              color: color,
              width: 2.h,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r))),
        onPressed: onPressed,
        child: Text(title, style: AppsTextStyle.button.copyWith(color: color)));
  }
}
