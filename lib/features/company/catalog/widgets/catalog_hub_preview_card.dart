import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/gradient_action_button.dart';
import '../../../../core/widgets/image/custom_image.dart';

class CatalogHubPreviewCard extends StatelessWidget {
  const CatalogHubPreviewCard({
    super.key,
    required this.name,
    required this.badge,
    required this.priceLine,
    required this.actionLabel,
    this.file,
    this.url,
    this.isOffer = false,
  });

  final String name;
  final String badge;
  final String priceLine;
  final String actionLabel;
  final File? file;
  final String? url;
  final bool isOffer;

  @override
  Widget build(BuildContext context) {
    final secondary = AppColors.textSecondaryColor.themeColor;
    final remote = url?.trim() ?? '';
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.studioPanelBorder.themeColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 90.h,
            color: AppColors.studioSelectFill.themeColor,
            alignment: Alignment.center,
            child: file != null
                ? Image.file(file!,
                    width: double.infinity, height: 90.h, fit: BoxFit.cover)
                : remote.isNotEmpty
                    ? CustomImage(
                        image: remote,
                        width: double.infinity,
                        height: 90.h,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        isOffer
                            ? Icons.work_outline_rounded
                            : Icons.restaurant_menu_rounded,
                        size: 26.sp,
                        color: AppColors.accentTeal.themeColor,
                      ),
          ),
          Padding(
            padding: EdgeInsets.all(14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: AppColors.studioSelectFill.themeColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: AppText(badge,
                      fontSize: 7.5.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 6.h),
                AppText(
                  name.trim().isEmpty
                      ? LocaleKeys.catalogHub_previewName.tr()
                      : name,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w800,
                ),
                if (priceLine.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  AppText(priceLine, fontSize: 9.sp, color: secondary),
                ],
                SizedBox(height: 10.h),
                GradientActionButton(
                  title: actionLabel,
                  centerTitle: true,
                  radius: 12,
                  minHeight: 40,
                  fontSize: 10,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
