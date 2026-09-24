import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CatalogItemActionBar extends StatelessWidget {
  const CatalogItemActionBar({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.white.themeColor,
      padding: EdgeInsets.fromLTRB(16.w, 11.h, 16.w, 10.h),
      child: CustomButton(
        onTap: onPressed,
        height: 50,
        customRadius: 16,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AppImages.iconsSend,
              height: 16.h,
              colorFilter:
                  ColorFilter.mode(AppColors.white.themeColor, BlendMode.srcIn),
            ),
            8.width,
            Flexible(
              child: AppText(
                label,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.overlayOnDark.themeColor,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
