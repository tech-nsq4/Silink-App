import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';

class CompanyPublicContactButton extends StatelessWidget {
  const CompanyPublicContactButton({
    super.key,
    required this.icon,
    required this.label,
    required this.background,
    required this.onTap,
  });

  final String icon;
  final String label;
  final Color background;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 62.w,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 46.w,
              height: 46.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                icon,
                width: 20.w,
                height: 20.w,
                colorFilter: ColorFilter.mode(
                  AppColors.overlayOnDark.themeColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            6.height,
            AppText(
              label,
              fontSize: 9.5.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryColor.themeColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
