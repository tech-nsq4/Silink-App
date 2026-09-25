import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';

class CompanyQrActionButton extends StatelessWidget {
  const CompanyQrActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.filled = true,
  });

  final String icon;
  final String label;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final foreground = filled
        ? AppColors.overlayOnDark.themeColor
        : AppColors.textPrimaryColor.themeColor;
    return CustomButton(
      onTap: onTap,
      height: 50,
      radius: 14,
      color: filled
          ? AppColors.companyBrand.themeColor
          : AppColors.cardColor.themeColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 17.w,
            height: 17.w,
            colorFilter: filled
                ? ColorFilter.mode(foreground, BlendMode.srcIn)
                : null,
          ),
          8.width,
          AppText(
            label,
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: foreground,
          ),
        ],
      ),
    );
  }
}
