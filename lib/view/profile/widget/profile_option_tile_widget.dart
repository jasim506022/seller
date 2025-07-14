import 'package:flutter/material.dart';

import '../../../res/apps_text_style.dart';

/// A reusable title for profile menu option
///
/// Displays an icon, title, and optional trailing arrow.
/// Handles tap actions for navigation or other interactions.
class ProfileMenuItemTileWidget extends StatelessWidget {
  const ProfileMenuItemTileWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.hasTrailingIcon = true,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;
  final bool hasTrailingIcon;

  @override
  Widget build(BuildContext context) {
    final Color effectiveIconColor = iconColor ?? Theme.of(context).primaryColor;
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: effectiveIconColor),
      title: Text(
        title,
        style: AppsTextStyle.largeBold.copyWith(color: effectiveIconColor),
      ),

      /// **Trailing Arrow (Optional)**
      trailing:
          hasTrailingIcon
              ?  IconButton(
                onPressed: onTap,
                icon: const Icon(Icons.arrow_forward_ios),
              )
              : const SizedBox.shrink(),
    );
  }
}
