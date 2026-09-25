import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCardLeadConsent extends StatelessWidget {
  const ProfileCardLeadConsent({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final mint = AppColors.mint.themeColor;

    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(8.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 20.w,
            height: 20.w,
            margin: EdgeInsets.only(top: 2.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: value ? mint : AppColors.white.themeColor,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(
                color: value ? mint : AppColors.borderColor.themeColor,
                width: 1.5,
              ),
            ),
            child: value
                ? Icon(Icons.check_rounded,
                    size: 14.sp, color: AppColors.white.themeColor)
                : null,
          ),
          10.width,
          Expanded(
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13.sp,
                  color: AppColors.textPrimaryColor.themeColor,
                ),
                children: [
                  TextSpan(text: label),
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: AppColors.errorColor.themeColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
