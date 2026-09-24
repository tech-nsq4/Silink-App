import 'package:Silink/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class ServiceProductCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final List<Color> imageGradient;
  final String? type;
  final String? price;

  const ServiceProductCard({
    super.key,
    required this.name,
    required this.icon,
    required this.imageGradient,
    this.type,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 110.h,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: imageGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: Colors.white, size: 26.sp),
          ),
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  name,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                  maxLines: 1,
                ),
                if (type != null) ...[
                  4.height,
                  AppText(
                    type!,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondaryColor.themeColor,
                  ),
                ],
                if (price != null) ...[
                  6.height,
                  AppText(
                    price!,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mint.themeColor,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}