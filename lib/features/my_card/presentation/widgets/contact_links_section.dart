import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/features/profile_completion/data/models/profile_completion_data.dart';
import 'package:Silink/features/my_card/presentation/widgets/contact_me_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_overlay.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import 'link_tile.dart';

class ContactLinksSection extends StatelessWidget {
  const ContactLinksSection({super.key, required this.data});

  final ProfileCompletionData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContactMeSection(data: data),
        18.height,
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: AppText(
            LocaleKeys.publish_contactLinks.tr(),
            fontSize: 11.5.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
        ),
        10.height,
        LinkTile(
          label: 'الموقع الإلكتروني',
          icon: Icons.language,
          onTap: () =>
              AppOverlay.showSuccess(LocaleKeys.common_comingSoon.tr()),
        ),
        10.height,
        LinkTile(
          label: 'احجز موعدًا',
          icon: Icons.calendar_today_outlined,
          filled: true,
          onTap: () =>
              AppOverlay.showSuccess(LocaleKeys.common_comingSoon.tr()),
        ),
        14.height,
        CustomButton(
          onTap: () =>
              AppOverlay.showSuccess(LocaleKeys.common_comingSoon.tr()),
          borderColor: AppColors.borderColor.themeColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppImages.iconsSend,
                height: 16.h,
                width: 16.w,
                colorFilter: ColorFilter.mode(
                  AppColors.white.themeColor,
                  BlendMode.srcIn,
                ),
              ),
              8.width,
              AppText(
                LocaleKeys.publish_share_data.tr(),
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.white.themeColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}