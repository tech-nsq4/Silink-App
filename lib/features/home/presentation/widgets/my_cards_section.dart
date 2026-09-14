import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class MyCardsSection extends StatelessWidget {
  final VoidCallback? onCompleteAndPublish;

  const MyCardsSection({super.key, this.onCompleteAndPublish});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(AppImages.iconsCard),
            8.width,
            AppText(
              LocaleKeys.home_my_cards_title.tr(),
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
        12.height,
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColors.white.themeColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.borderColor.themeColor),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(AppImages.iconsQrCode),
              12.height,
              AppText(
                LocaleKeys.home_card_not_published_title.tr(),
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
              6.height,
              AppText(
                LocaleKeys.home_card_not_published_subtitle.tr(),
                fontSize: 12.sp,
                textAlign: TextAlign.center,
              ),
              8.height,
              InkWell(
                onTap: onCompleteAndPublish ?? () {},
                child: AppText(
                  LocaleKeys.home_complete_and_publish.tr(),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mint.themeColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
