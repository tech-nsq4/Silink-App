import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FontStyleOption extends StatelessWidget {
  const FontStyleOption({
    super.key,
    required this.label,
    required this.fontFamily,
    required this.sampleText,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String fontFamily;
  final String sampleText;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.mint.themeColor.withValues(alpha: 0.08)
              : AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: selected
                ? AppColors.mint.themeColor
                : AppColors.dividerColor.themeColor,
            width: selected ? 1.6 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  selected ? Icons.check_circle : Icons.circle_outlined,
                  size: 18.sp,
                  color: selected
                      ? AppColors.mint.themeColor
                      : AppColors.dividerColor.themeColor,
                ),
                8.width,
                AppText(label, fontSize: 13.sp, fontWeight: FontWeight.w600),
              ],
            ),
            AppText(
              sampleText,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              fontFamily: fontFamily,
            ),
          ],
        ),
      ),
    );
  }
}
