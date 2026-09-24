import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompanyCardsEmptyState extends StatelessWidget {
  const CompanyCardsEmptyState({
    super.key,
    required this.title,
    required this.desc,
  });

  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppImages.iconsCard,
              width: 56.w,
              height: 56.h,
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                AppColors.textSecondaryColor.themeColor.withValues(alpha: 0.4),
                BlendMode.srcIn,
              ),
            ),
            16.height,
            AppText(title, fontSize: 15.sp, fontWeight: FontWeight.w700),
            6.height,
            AppText(
              desc,
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
