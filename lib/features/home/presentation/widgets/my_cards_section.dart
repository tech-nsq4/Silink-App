import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/features/profile_completion/data/models/profile_completion_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class MyCardsSection extends StatelessWidget {
  final VoidCallback? onCompleteAndPublish;
  final ProfileCompletionData? cardData;

  const MyCardsSection({super.key, this.onCompleteAndPublish, this.cardData});

  bool get _hasCard =>
      cardData != null &&
      (cardData!.fullName.trim().isNotEmpty || cardData!.products.isNotEmpty);

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
      
        _hasCard
            ? _PublishedCard(
                data: cardData!,
                onEdit: onCompleteAndPublish,
                onTap: () => NavigationService.push(
                  Routes.layoutScreen,
                  arguments: {'data': cardData},
                ),
              )
            : _EmptyCard(
                onCompleteAndPublish: () =>
                    NavigationService.push(Routes.usageTypeScreen)),
      ],
    );
  }
}

class _EmptyCard extends StatelessWidget {
  final VoidCallback? onCompleteAndPublish;

  const _EmptyCard({this.onCompleteAndPublish});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Container(
            height: 56.h,
            width: 56.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.fieldFill,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: SvgPicture.asset(
              AppImages.iconsCard,
              height: 24.h,
              colorFilter: ColorFilter.mode(
                AppColors.textSecondaryColor.themeColor.withValues(alpha: 0.5),
                BlendMode.srcIn,
              ),
            ),
          ),
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
            maxLines: 2,
          ),
          8.height,
          CustomButton(
            onTap: onCompleteAndPublish ?? () {},
            title: LocaleKeys.home_start_creating_profile.tr(),
          ),
        ],
      ),
    );
  }
}

class _PublishedCard extends StatelessWidget {
  final ProfileCompletionData data;
  final VoidCallback? onEdit;
  final VoidCallback onTap;

  const _PublishedCard({
    required this.data,
    this.onEdit,
    required this.onTap,
  });

  String get _handle => data.fullName.trim().isEmpty
      ? 'demo-profile'
      : data.fullName.trim().replaceAll(' ', '-');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 64.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Color(0xff2C9092), Color(0xff2368E2)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )),
              ),
              PositionedDirectional(
                top: 10.h,
                end: 10.w,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: AppText(
                    LocaleKeys.home_published_badge.tr(),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              PositionedDirectional(
                start: 14.w,
                bottom: -24.h,
                child: Container(
                  width: 56.w,
                  height: 56.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.mint.themeColor,
                    borderRadius: BorderRadius.circular(18.r),
                    border:
                        Border.all(color: AppColors.white.themeColor, width: 3),
                  ),
                  child: AppText(
                    data.fullName.initial,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white.themeColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 32.h),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  data.fullName.trim().isEmpty
                      ? LocaleKeys.profile_type_basic_info_full_name_hint.tr()
                      : data.fullName.trim(),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.end,
                ),
                if (data.jobTitle.trim().isNotEmpty) ...[
                  2.height,
                  AppText(
                    data.jobTitle.trim(),
                    fontSize: 12.sp,
                    color: AppColors.textSecondaryColor.themeColor,
                    textAlign: TextAlign.end,
                  ),
                ],
                4.height,
                AppText(
                  'silink.nsq4.sa/$_handle',
                  fontSize: 11.sp,
                  color: AppColors.textSecondaryColor.themeColor,
                  textAlign: TextAlign.end,
                ),
                14.height,
                Divider(height: 1, color: AppColors.borderColor.themeColor),
              ],
            ),
          ),
          SizedBox(
            height: 50.h,
            child: IntrinsicHeight(
              child: Row(
                children: [
                  _rowButton(
                    title: LocaleKeys.publish_viewCard.tr(),
                    icon: AppImages.iconsPreview,
                    onTap: onTap,
                    color: AppColors.mint.themeColor,
                  ),
                  _rowButton(
                    title: LocaleKeys.home_edit_profile.tr(),
                    icon: AppImages.iconsEdit,
                    onTap: onTap,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _rowButton({
    required String title,
    required String icon,
    required VoidCallback onTap,
    Color? color,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: 16.h,
              colorFilter: ColorFilter.mode(
                color ?? AppColors.textPrimaryColor.themeColor,
                BlendMode.srcIn,
              ),
            ),
            4.height,
            AppText(
              title,
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: color ?? AppColors.textPrimaryColor.themeColor,
            ),
          ],
        ),
      ),
    );
  }
}
