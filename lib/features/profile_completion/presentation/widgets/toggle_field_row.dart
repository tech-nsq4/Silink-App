import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToggleFieldRow extends StatelessWidget {
  const ToggleFieldRow({
    super.key,
    required this.title,
    required this.hint,
    required this.value,
    required this.enabled,
    required this.badge,
    required this.onToggle,
    required this.onEditTap,
  });

  final String title;
  final String hint;
  final String value;
  final bool enabled;
  final Widget badge;
  final ValueChanged<bool> onToggle;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.dividerColor.themeColor),
      ),
      child: Row(
        children: [
          badge,
          8.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  title,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                ),
                0.height,
                AppText(
                  value.isEmpty ? hint : value,
                  fontSize: 11.sp,
                  color:value.isEmpty ? Colors.grey.shade300: AppColors.textSecondaryColor.themeColor,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          InkWell(
            onTap: onEditTap,
            borderRadius: BorderRadius.circular(20.r),
            child: Padding(
              padding: EdgeInsets.all(6.w),
              child: Icon(
                Icons.edit_outlined,
                size: 18.sp,
                color: AppColors.textSecondaryColor.themeColor,
              ),
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: enabled,
              onChanged: onToggle,
              activeThumbColor: AppColors.mint.themeColor,
            ),
          ),



        ],
      ),
    );
  }
}
