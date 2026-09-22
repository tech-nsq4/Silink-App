import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_tap_effect.dart';

class AccountLinkButton extends StatelessWidget {
  const AccountLinkButton({
    super.key,
    required this.label,
    this.onTap,
    this.color,
    this.underlineColor,
  });

  final String label;
  final VoidCallback? onTap;
  final Color? color;
  final Color? underlineColor;

  @override
  Widget build(BuildContext context) {
    final tone = color ?? AppColors.textSecondaryColor.themeColor;

    return CustomTapEffect(
      onTap: onTap,
      child: Container(
        padding: EdgeInsetsDirectional.only(bottom: 3.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: underlineColor ?? tone,
              width: 1,
            ),
          ),
        ),
        child: AppText(
          label,
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          color: tone,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
