import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/extensions.dart';
import '../utils/app_colors.dart';
import 'app_button.dart';
import 'app_text.dart';

class BottomActionBar extends StatelessWidget {
  const BottomActionBar({
    super.key,
    required this.title,
    required this.onTap,
    this.secondaryTitle,
    this.onSecondaryTap,
    this.note,
    this.loading = false,
    this.enabled = true,
  });

  final String title;
  final VoidCallback onTap;
  final String? secondaryTitle;
  final VoidCallback? onSecondaryTap;
  final String? note;
  final bool loading;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor.themeColor,
        border: Border(
          top: BorderSide(color: AppColors.borderColor.themeColor, width: 0.5),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: 19.paddingHorizontal + 14.paddingVert,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                onTap: enabled ? onTap : () {},
                title: title,
                height: 50,
                loading: loading,
                fontSize: 14.sp,
                color: enabled ? null : AppColors.disabledColor.themeColor,
              ),
              if (secondaryTitle != null && onSecondaryTap != null) ...[
                10.height,
                CustomButton(
                  onTap: onSecondaryTap!,
                  title: secondaryTitle,
                  height: 50,
                  fontSize: 14.sp,
                  color: AppColors.cardColor.themeColor,
                  borderColor: AppColors.borderColor.themeColor,
                  textColor: AppColors.textPrimaryColor.themeColor,
                ),
              ],
              if (note != null) ...[
                8.height,
                AppText(
                  note!,
                  fontSize: 11.sp,
                  color: AppColors.textSecondaryColor.themeColor,
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
