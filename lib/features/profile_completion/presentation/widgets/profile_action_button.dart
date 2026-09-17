import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class ProfileActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final VoidCallback onTap;

  const ProfileActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52.w,
            height: 52.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
            child: Icon(icon, size: 20.sp, color: Colors.white),
          ),
          6.height,
          AppText(
            label,
            fontSize: 11.sp,
            color: AppColors.textSecondaryColor.themeColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
