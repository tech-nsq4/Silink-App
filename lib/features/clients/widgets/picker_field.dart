import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// حقل اختيار التاريخ/الوقت — pill قابل للنقر بأيقونة على الطرف.
class PickerField extends StatelessWidget {
  const PickerField({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.isPlaceholder = false,
  });

  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final bool isPlaceholder;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.borderColor.themeColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: AppText(
                text,
                textAlign: TextAlign.center,
                fontSize: 12.sp,
              ),
            ),
            8.width,
            Icon(
              icon,
              size: 16.sp,
              color: AppColors.textSecondaryColor.themeColor,
            ),
          ],
        ),
      ),
    );
  }
}
