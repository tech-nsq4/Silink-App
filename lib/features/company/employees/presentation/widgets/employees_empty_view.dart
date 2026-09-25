import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmployeesEmptyView extends StatelessWidget {
  const EmployeesEmptyView({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64.w,
              height: 64.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.surfaceColor.themeColor,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: SvgPicture.asset(
                AppImages.iconsWork,
                width: 28.w,
                height: 28.h,
                colorFilter: ColorFilter.mode(
                  AppColors.textSecondaryColor.themeColor
                      .withValues(alpha: 0.4),
                  BlendMode.srcIn,
                ),
              ),
            ),
            16.height,
            AppText(title, fontSize: 15.sp, fontWeight: FontWeight.w700),
            6.height,
            AppText(
              description,
              fontSize: 13.sp,
              color: AppColors.textSecondaryColor.themeColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
