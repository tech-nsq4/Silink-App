import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class ShopCardMockup extends StatelessWidget {
  const ShopCardMockup({
    super.key,
    required this.showBack,
    required this.cardColor,
    required this.printColor,
    required this.name,
    required this.jobTitle,
    required this.company,
    this.logo,
  });

  final bool showBack;
  final Color cardColor;
  final Color printColor;
  final String name;
  final String jobTitle;
  final String company;
  final File? logo;

  Widget _logoBox(double size) {
    final initial = name.trim().isEmpty ? '' : name.trim().characters.first;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: printColor.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(size * 0.22),
      ),
      child: logo != null
          ? Image.file(logo!, width: size, height: size, fit: BoxFit.cover)
          : AppText(
              initial,
              fontSize: size * 0.4,
              fontWeight: FontWeight.w800,
              color: printColor,
            ),
    );
  }

  Widget _circle(double size) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: printColor.withValues(alpha: 0.06),
        ),
      );

  Widget _front() => Padding(
        padding: EdgeInsets.all(18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _logoBox(30.w),
            SizedBox(height: 14.h),
            AppText(
              name,
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
              color: printColor,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            AppText(jobTitle,
                fontSize: 8.sp,
                color: printColor.withValues(alpha: 0.85),
                maxLines: 1),
            SizedBox(height: 3.h),
            AppText(company,
                fontSize: 7.5.sp,
                color: printColor.withValues(alpha: 0.65),
                maxLines: 1),
            const Spacer(),
            Row(
              children: [
                for (final icon in [
                  Icons.crop_square_rounded,
                  Icons.diamond_outlined,
                  Icons.circle_outlined,
                ]) ...[
                  Container(
                    width: 20.w,
                    height: 20.w,
                    margin: EdgeInsetsDirectional.only(end: 6.w),
                    decoration: BoxDecoration(
                      color: printColor.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Icon(icon, size: 10.sp, color: printColor),
                  ),
                ],
              ],
            ),
          ],
        ),
      );

  Widget _back() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _logoBox(44.w),
            SizedBox(height: 12.h),
            Icon(Icons.qr_code_2_rounded, size: 34.sp, color: printColor),
            SizedBox(height: 8.h),
            Directionality(
              textDirection: TextDirection.ltr,
              child: AppText(
                'Silink',
                fontSize: 10.sp,
                fontWeight: FontWeight.w800,
                color: printColor.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.68,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.studioPanelBorder.themeColor),
          boxShadow: [
            BoxShadow(
              color:
                  AppColors.studioCardStart.themeColor.withValues(alpha: 0.15),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            PositionedDirectional(
                top: -30.h, start: -30.w, child: _circle(90.w)),
            PositionedDirectional(
                bottom: -45.h, end: -20.w, child: _circle(110.w)),
            Positioned.fill(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: KeyedSubtree(
                  key: ValueKey(showBack),
                  child: showBack ? _back() : _front(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
