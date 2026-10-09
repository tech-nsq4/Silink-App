import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/image/custom_image.dart';

class HubCompanyHead extends StatelessWidget {
  const HubCompanyHead({
    super.key,
    required this.name,
    required this.meta,
    this.logoUrl,
  });

  final String name;
  final String meta;
  final String? logoUrl;

  String get _initials {
    final words = name.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty);
    return words.take(2).map((w) => w.characters.first).join();
  }

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    final logo = logoUrl?.trim() ?? '';
    final size = 50.w;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5.w),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Container(
            width: size,
            height: size,
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: logo.isNotEmpty
                ? CustomImage(
                    image: logo,
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                  )
                : AppText(
                    _initials,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white.light,
                  ),
          ),
        ),
        SizedBox(height: 14.h),
        AppText(
          name,
          fontSize: 20.sp,
          fontWeight: FontWeight.w800,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_on_outlined,
                size: 12.sp, color: AppColors.textSecondaryColor.themeColor),
            4.width,
            AppText(
              meta,
              fontSize: 8.5.sp,
              color: AppColors.textSecondaryColor.themeColor,
            ),
          ],
        ),
      ],
    );
  }
}
