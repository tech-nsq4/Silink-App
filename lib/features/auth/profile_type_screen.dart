import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/profile_completion/data/models/profile_completion_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileTypeStep extends StatelessWidget {
  final ProfileType? selected;
  final ValueChanged<ProfileType> onSelected;

  const ProfileTypeStep({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            LocaleKeys.profile_type_subTitle.tr(),
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
          4.height,
          AppText(
            LocaleKeys.profile_type_footerHint.tr(),
            fontSize: 14.sp,
          ),
          16.height,
          _TypeCard(
            title: LocaleKeys.profile_type_work_title.tr(),
            subtitle: LocaleKeys.profile_type_work_subtitle.tr(),
            icon: AppImages.iconsWork,
            selected: selected == ProfileType.work,
            onTap: () => onSelected(ProfileType.work),
          ),
          const SizedBox(height: 14),
          _TypeCard(
            title: LocaleKeys.profile_type_personal_title.tr(),
            subtitle: LocaleKeys.profile_type_personal_subtitle.tr(),
            icon: AppImages.iconsPersonal,
            selected: selected == ProfileType.personal,
            onTap: () => onSelected(ProfileType.personal),
          ),
          const SizedBox(height: 14),
          _TypeCard(
            title: LocaleKeys.profile_type_freelancer_title.tr(),
            subtitle: LocaleKeys.profile_type_freelancer_subtitle.tr(),
            icon: AppImages.aiIcon,
            selected: selected == ProfileType.freelancer,
            onTap: () => onSelected(ProfileType.freelancer),
          ),
        ],
      ),
    );
  }
}

class _TypeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final bool selected;
  final VoidCallback onTap;

  const _TypeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFEFF4FF) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? const Color(0xFF2F6FED) : const Color(0xFFE9EBEF),
            width: selected ? 1.6 : 1,
          ),
          boxShadow: const [
            BoxShadow(
                color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.blue.themeColor
                    : const Color(0xFFF2F3F6),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(
                  selected
                      ? AppColors.white.themeColor
                      : AppColors.textSecondaryColor.themeColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A1A),
                  ),
                  4.height,
                  AppText(
                    subtitle,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondaryColor.themeColor.withOpacity(0.8),
                  ),
                ],
              ),
            ),
            if (selected)
              Icon(
                Icons.check_circle_outline,
                color: Color(0xFF2F6FED),
                size: 20.r,
              ),
          ],
        ),
      ),
    );
  }
}
