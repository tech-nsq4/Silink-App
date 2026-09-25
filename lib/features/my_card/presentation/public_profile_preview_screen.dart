import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/profile_completion/data/models/profile_completion_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/router/navigation_services.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../widgets/about_me_card.dart';
import '../widgets/contact_links_section.dart';
import '../widgets/cover_with_exit.dart';
import '../widgets/profile_header.dart';
import '../widgets/quick_actions_row.dart';
import '../widgets/services_section.dart';

class PublicProfilePreviewScreen extends StatelessWidget {
  const PublicProfilePreviewScreen({super.key, required this.data});

  final ProfileCompletionData data;

  static const List<Map<String, dynamic>> _services = [
    {
      'name': 'ورشة تطوير استراتيجية',
      'type': 'خدمة',
      'price': 'يبدأ من 1200 ر.س',
      'icon': Icons.work_outline_rounded,
      'gradient': [Color(0xFFD9B76A), Color(0xFF8A6A2F)],
    },
    {
      'name': 'استشارة اعمال',
      'type': 'خدمة',
      'price': 'يبدأ من 500 ر.س',
      'icon': Icons.groups_outlined,
      'gradient': [Color(0xFF17B78F), Color(0xFF2F6FED)],
    },
    {
      'name': 'جلسة تدريب فردية',
      'type': 'خدمة',
      'price': 'يبدأ من 300 ر.س',
      'icon': Icons.school_outlined,
      'gradient': [Color(0xFF2F6FED), Color(0xFF17B78F)],
    },
    {
      'name': 'تقييم مؤسسي',
      'type': 'خدمة',
      'price': 'يبدأ من 900 ر.س',
      'icon': Icons.fact_check_outlined,
      'gradient': [Color(0xFF8A6A2F), Color(0xFFD9B76A)],
    },
  ];

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'channels: ${data.channels.entries.map((e) => '${e.key}: enabled=${e.value.enabled}, value="${e.value.value}"').join(' | ')}');
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CoverWithExit(onExit: () => NavigationService.goBack()),
            Transform.translate(
              offset: Offset(0, -50.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 19.w),
                child: Column(
                  children: [
                    ProfileHeader(
                      fullName: data.fullName,
                      jobTitle: data.jobTitle,
                      company: data.company,
                      location: data.location,
                    ),
                    16.height,
                    AboutMeCard(bio: data.bio),
                    16.height,
                    const QuickActionsRow(),
                    22.height,
                    Divider(height: 1, color: AppColors.borderColor.themeColor),
                    16.height,
                    ServicesSection(services: _services),
                    18.height,
                    ContactLinksSection(
                      data: data,
                    ),
                    22.height,
                    CustomButton(
                      onTap: () {},
                      width: 140.w,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppImages.iconsShare,
                            height: 15.h,
                            width: 15.w,
                            colorFilter: ColorFilter.mode(
                              AppColors.white.themeColor,
                              BlendMode.srcIn,
                            ),  
                          ),
                          8.width,
                          AppText(
                            LocaleKeys.publish_file_sharing.tr(),
                            fontWeight: FontWeight.w700,
                            color: AppColors.white.themeColor,
                          ),
                        ],
                      ),
                    ),
                    24.height,
                    AppText(
                      LocaleKeys.publish_made_with.tr(),
                      fontSize: 10.sp,
                      color: AppColors.textSecondaryColor.themeColor,
                    ),
                    4.height,
                    Container(
                      height: 24.h,
                      width: 68.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        image: DecorationImage(
                          image: AssetImage(AppImages.logoApp),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    24.height,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
