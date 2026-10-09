import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import 'shop_tilted_card.dart';

class ShopHeroBanner extends StatelessWidget {
  const ShopHeroBanner({super.key, required this.onDiscover});

  final VoidCallback onDiscover;

  @override
  Widget build(BuildContext context) {
    final white = AppColors.white.light;
    final mint = AppColors.mint.themeColor;
    return Container(
      height: 170.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.r),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            AppColors.studioCardStart.themeColor,
            AppColors.studioCardEnd.themeColor,
          ],
        ),
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            end: -18.w,
            top: 28.h,
            child: ShopTiltedCard(
              color: AppColors.accentTeal.themeColor,
              width: 150.w,
              angle: -0.22,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.w, 22.h, 150.w, 18.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  LocaleKeys.shop_heroEyebrow.tr(),
                  fontSize: 8.5.sp,
                  color: mint,
                ),
                SizedBox(height: 8.h),
                AppText(
                  LocaleKeys.shop_heroTitle.tr(),
                  fontSize: 17.sp,
                  height: 1.4,
                  fontWeight: FontWeight.w800,
                  color: white,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onDiscover,
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        LocaleKeys.shop_heroCta.tr(),
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w700,
                        color: mint,
                      ),
                      6.width,
                      Icon(Icons.arrow_back_rounded, size: 14.sp, color: mint),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
