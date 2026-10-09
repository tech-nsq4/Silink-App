import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/app_text.dart';

class OrderLinkButton extends StatelessWidget {
  const OrderLinkButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.textSecondaryColor.themeColor;
    return Center(
      child: TextButton(
        onPressed: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14.sp, color: color),
              6.width,
            ],
            AppText(label, fontSize: 9.sp, color: color),
          ],
        ),
      ),
    );
  }
}
