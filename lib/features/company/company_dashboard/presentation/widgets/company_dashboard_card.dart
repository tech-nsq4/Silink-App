import 'dart:io';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyDashboardCard extends StatelessWidget {
  const CompanyDashboardCard({
    super.key,
    required this.companyName,
    this.industry,
    this.city,
    this.logoUrl,
    this.imagePath,
  });

  final String companyName;
  final String? industry;
  final String? city;
  final String? logoUrl;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    final name = companyName.trim().isEmpty ? 'Q' : companyName.trim();
    final initial =
        companyName.trim().isEmpty ? 'Q' : companyName.trim()[0].toUpperCase();
    final hasImage = imagePath != null && imagePath!.trim().isNotEmpty;
    final fallback = AppText(
      initial,
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.white.themeColor,
    );

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardColor.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: Row(
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: AppColors.blue.themeColor,
              borderRadius: BorderRadius.circular(18.r),
            ),
            clipBehavior: Clip.antiAlias,
            child: hasImage
                ? Image.file(
                    File(imagePath!),
                    width: 64.w,
                    height: 64.w,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Center(child: fallback),
                  )
                : Center(child: fallback),
          ),
          16.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  name,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
                if (industry != null && industry!.isNotEmpty) ...[
                  2.height,
                  AppText(
                    industry!,
                    fontSize: 12.sp,
                    color: AppColors.textSecondaryColor.themeColor,
                  ),
                ],
                if (city != null && city!.isNotEmpty) ...[
                  2.height,
                  AppText(
                    city!,
                    fontSize: 12.sp,
                    color: AppColors.textSecondaryColor.themeColor,
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
