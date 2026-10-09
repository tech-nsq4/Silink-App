import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/locale_keys.dart';
import '../app_text.dart';
import '../image/custom_image.dart';
import 'public_profile_data.dart';

class PublicProfileItemCard extends StatelessWidget {
  const PublicProfileItemCard({
    super.key,
    required this.item,
    required this.index,
    required this.accent,
    required this.onTap,
  });

  final PublicProfileItem item;
  final int index;
  final Color accent;
  final VoidCallback onTap;

  String get _footerText {
    if (item.price.trim().isEmpty) {
      return LocaleKeys.publicProfile_itemDetails.tr();
    }
    final label = item.priceLabel.trim();
    final currency = LocaleKeys.publicProfile_currency.tr();
    return '${label.isNotEmpty && label != currency ? '$label ' : ''}${item.price} $currency';
  }

  @override
  Widget build(BuildContext context) {
    final white = AppColors.white.light;
    final service = item.isService;
    final imageUrl = item.imageUrl?.trim() ?? '';
    final hasImage = item.imageFile != null || imageUrl.isNotEmpty;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.profileLine.themeColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 126.h,
              child: Container(
                color: service
                    ? AppColors.profileItemArt.themeColor
                    : AppColors.profileProductArt.themeColor,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (item.imageFile != null)
                      Positioned.fill(
                        child: Image.file(item.imageFile!, fit: BoxFit.cover),
                      )
                    else if (imageUrl.isNotEmpty)
                      Positioned.fill(
                        child: CustomImage(image: imageUrl, fit: BoxFit.cover),
                      )
                    else ...[
                      Positioned(
                        left: -70.w,
                        top: -65.h,
                        child: Container(
                          width: 160.w,
                          height: 160.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: white.withValues(alpha: 0.53)),
                            boxShadow: [
                              BoxShadow(
                                color: white.withValues(alpha: 0.125),
                                spreadRadius: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Transform.rotate(
                        angle: -12 * math.pi / 180,
                        child: Icon(
                          service
                              ? Icons.work_outline_rounded
                              : Icons.inventory_2_outlined,
                          size: 29.sp,
                          color: service
                              ? AppColors.profileItemIcon.themeColor
                              : AppColors.profileProductIcon.themeColor,
                        ),
                      ),
                    ],
                    if (!hasImage)
                      PositionedDirectional(
                        bottom: 13.h,
                        start: 13.w,
                        child: AppText(
                          (index + 1).toString().padLeft(2, '0'),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.profileItemNumber.themeColor,
                        ),
                      ),
                    PositionedDirectional(
                      top: 9.h,
                      end: 9.w,
                      child: Container(
                        width: 24.w,
                        height: 24.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: white.withValues(alpha: 0.56),
                        ),
                        child: Icon(Icons.north_west_rounded,
                            size: 14.sp,
                            color: AppColors.profileItemArrow.themeColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 13.h, 12.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    service
                        ? LocaleKeys.publicProfile_kindService.tr()
                        : LocaleKeys.publicProfile_kindProduct.tr(),
                    fontSize: 7.sp,
                    color: AppColors.profileItemKind.themeColor,
                  ),
                  SizedBox(height: 7.h),
                  AppText(
                    item.name,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    height: 1.7,
                    color: AppColors.profileItemTitle.themeColor,
                  ),
                  if (item.description.trim().isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    AppText(
                      item.description,
                      fontSize: 8.sp,
                      height: 1.9,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      color: AppColors.profileBody.themeColor,
                    ),
                  ],
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.only(top: 11.h),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            color: AppColors.profileItemFooterLine.themeColor),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: AppText(
                            _footerText,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w700,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            color: accent,
                          ),
                        ),
                        Icon(Icons.arrow_forward_rounded,
                            size: 12.sp,
                            color: AppColors.profileItemFooterIcon.themeColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
