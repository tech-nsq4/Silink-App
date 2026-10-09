import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_tap_effect.dart';

class HubOutlineButton extends StatelessWidget {
  const HubOutlineButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomTapEffect(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 13.h),
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.studioPanelBorder.themeColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 17.sp, color: AppColors.textPrimaryColor.themeColor),
            8.width,
            AppText(label, fontSize: 9.5.sp, fontWeight: FontWeight.w700),
          ],
        ),
      ),
    );
  }
}
