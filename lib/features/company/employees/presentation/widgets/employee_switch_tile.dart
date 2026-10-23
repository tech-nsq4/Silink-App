import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';

class EmployeeSwitchTile extends StatelessWidget {
  const EmployeeSwitchTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.showDivider = true,
  });

  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool enabled;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
        start: 16.w,
        end: 8.w,
        top: 6.h,
        bottom: 6.h,
      ),
      decoration: BoxDecoration(
        border: showDivider
            ? Border(
                bottom: BorderSide(color: AppColors.studioStepLine.themeColor),
              )
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.studioSelectFill.themeColor,
              borderRadius: BorderRadius.circular(11.r),
            ),
            child: Icon(
              icon,
              size: 18.sp,
              color: AppColors.textSecondaryColor.themeColor,
            ),
          ),
          12.width,
          Expanded(
            child: AppText(
              title,
              fontSize: 11.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          Switch(
            value: value,
            activeThumbColor: Colors.white,
            activeTrackColor: AppColors.successColor.themeColor,
            onChanged: enabled ? onChanged : null,
          ),
        ],
      ),
    );
  }
}
