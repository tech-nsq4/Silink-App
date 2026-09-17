import 'package:Silink/features/profile_completion/models/initial_char.dart';
import 'package:Silink/features/profile_completion/models/profile_completion_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/navigation_services.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import 'widgets/cover_with_exit.dart';
import 'widgets/dots_indicator.dart';
import 'widgets/link_tile.dart';
import 'widgets/profile_action_button.dart';
import 'widgets/section_card.dart';
import 'widgets/service_product_card.dart';
import 'widgets/social_chip.dart';

class PublicProfilePreviewScreen extends StatefulWidget {
  const PublicProfilePreviewScreen({super.key, required this.data});

  final ProfileCompletionData data;

  @override
  State<PublicProfilePreviewScreen> createState() =>
      _PublicProfilePreviewScreenState();
}

class _PublicProfilePreviewScreenState
    extends State<PublicProfilePreviewScreen> {
  final PageController _servicesController = PageController();
  int _servicesPage = 0;

  ProfileCompletionData get data => widget.data;

  // استبدلها بالداتا الحقيقية
  final List<Map<String, dynamic>> _services = const [
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
  void dispose() {
    _servicesController.dispose();
    super.dispose();
  }

  int get _pagesCount => (_services.length / 2).ceil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CoverWithExit(onExit: () => NavigationService.goBack()),
            Transform.translate(
              offset: Offset(0, -44.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 19.w),
                child: Column(
                  children: [
                    Container(
                      width: 88.w,
                      height: 88.w,
                      decoration: BoxDecoration(
                        color: AppColors.mint.themeColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                      alignment: Alignment.center,
                      child: AppText(
                        data.fullName.initial,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    8.height,
                    AppText(data.fullName,
                        fontSize: 20.sp, fontWeight: FontWeight.w800),
                    4.height,
                    if (data.jobTitle.trim().isNotEmpty)
                      AppText(
                        data.jobTitle,
                        fontSize: 13.sp,
                        color: AppColors.textSecondaryColor.themeColor,
                      ),
                    if (data.company.trim().isNotEmpty)
                      AppText(
                        data.company,
                        fontSize: 12.sp,
                        color: AppColors.textSecondaryColor.themeColor,
                      ),
                    if (data.location.trim().isNotEmpty) ...[
                      10.height,
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: AppColors.white.themeColor,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                              color: AppColors.borderColor.themeColor),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.location_on_outlined,
                                size: 14.sp,
                                color:
                                    AppColors.textSecondaryColor.themeColor),
                            6.width,
                            AppText(
                              data.location,
                              fontSize: 11.5.sp,
                              color: AppColors.textSecondaryColor.themeColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (data.bio.trim().isNotEmpty) ...[
                      18.height,
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: AppColors.white.themeColor,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                              color: AppColors.borderColor.themeColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              LocaleKeys.publish_aboutMe.tr(),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            6.height,
                            AppText(
                              data.bio,
                              fontSize: 12.sp,
                              color: AppColors.textSecondaryColor.themeColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                    18.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ProfileActionButton(
                          icon: Icons.person_add_alt_1,
                          label: LocaleKeys.publish_saveContact.tr(),
                          backgroundColor: const Color(0xFF17212B),
                          onTap: () => AppOverlay.showSuccess(
                              LocaleKeys.common_comingSoon.tr()),
                        ),
                        ProfileActionButton(
                          icon: Icons.mail_outline,
                          label: LocaleKeys.publish_cardEmail.tr(),
                          backgroundColor: AppColors.mint.themeColor,
                          onTap: () => AppOverlay.showSuccess(
                              LocaleKeys.common_comingSoon.tr()),
                        ),
                        ProfileActionButton(
                          icon: Icons.chat_bubble_outline,
                          label: LocaleKeys.publish_whatsapp.tr(),
                          backgroundColor: const Color(0xFF25D366),
                          onTap: () => AppOverlay.showSuccess(
                              LocaleKeys.common_comingSoon.tr()),
                        ),
                        ProfileActionButton(
                          icon: Icons.call_outlined,
                          label: LocaleKeys.publish_call.tr(),
                          backgroundColor: AppColors.mint.themeColor,
                          onTap: () => AppOverlay.showSuccess(
                              LocaleKeys.common_comingSoon.tr()),
                        ),
                      ],
                    ),
                    22.height,
                    Divider(height: 1, color: AppColors.borderColor.themeColor),
                    16.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          LocaleKeys.publish_viewAll.tr(),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2F6FED),
                        ),
                        AppText(
                          LocaleKeys.publish_productsAndServices.tr(),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ],
                    ),
                    12.height,

                    // ===== سلايدر الخدمات =====
                    SizedBox(
                      height: 190.h,
                      child: PageView.builder(
                        controller: _servicesController,
                        itemCount: _pagesCount,
                        onPageChanged: (i) =>
                            setState(() => _servicesPage = i),
                        itemBuilder: (context, pageIndex) {
                          final first = pageIndex * 2;
                          final second = first + 1;
                          return Row(
                            children: [
                              Expanded(child: _serviceCard(_services[first])),
                              10.width,
                              Expanded(
                                child: second < _services.length
                                    ? _serviceCard(_services[second])
                                    : const SizedBox(),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    12.height,
                    DotsIndicator(count: _pagesCount, current: _servicesPage),
                    18.height,

                    // ===== تواصل معي =====
                    SectionCard(
                      title: LocaleKeys.publish_contactMe.tr(),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 10.w,
                        runSpacing: 10.h,
                        children: [
                          SocialChip(
                            label: 'لينكد إن',
                            icon: Icons.business_center,
                            color: const Color(0xFF0A66C2),
                            background: const Color(0xFFEFF5FC),
                            onTap: () => AppOverlay.showSuccess(
                                LocaleKeys.common_comingSoon.tr()),
                          ),
                          SocialChip(
                            label: 'واتساب',
                            icon: Icons.chat,
                            color: const Color(0xFF25D366),
                            background: const Color(0xFFEFFAF3),
                            onTap: () => AppOverlay.showSuccess(
                                LocaleKeys.common_comingSoon.tr()),
                          ),
                          SocialChip(
                            label: 'إنستقرام',
                            icon: Icons.camera_alt,
                            color: const Color(0xFFE1306C),
                            background: const Color(0xFFFDEFF4),
                            onTap: () => AppOverlay.showSuccess(
                                LocaleKeys.common_comingSoon.tr()),
                          ),
                        ],
                      ),
                    ),
                    18.height,

                    // ===== روابط التواصل =====
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
                      onTap: () => AppOverlay.showSuccess(
                          LocaleKeys.common_comingSoon.tr()),
                    ),
                    10.height,
                    LinkTile(
                      label: 'احجز موعدًا',
                      icon: Icons.calendar_today_outlined,
                      filled: true,
                      onTap: () => AppOverlay.showSuccess(
                          LocaleKeys.common_comingSoon.tr()),
                    ),
                    14.height,

                    // ===== أزرار المشاركة =====
                    // GradientButton(
                    //   label: 'شارك بياناتك معي',
                    //   icon: Icons.send_rounded,
                    //   onTap: () => AppOverlay.showSuccess(
                    //       LocaleKeys.common_comingSoon.tr()),
                    // ),
                    // 12.height,
                    // OutlinedShareButton(
                    //   label: 'مشاركة الملف',
                    //   icon: Icons.ios_share_rounded,
                    //   onTap: () => AppOverlay.showSuccess(
                    //       LocaleKeys.common_comingSoon.tr()),
                    // ),
                    22.height,

                    // ===== الفوتر =====
                    AppText(
                      'صنع بـ',
                      fontSize: 10.sp,
                      color: AppColors.textSecondaryColor.themeColor,
                    ),
                    6.height,
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 7.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF17212B),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: AppText(
                        'Silink',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
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

  Widget _serviceCard(Map<String, dynamic> s) => ServiceProductCard(
        name: s['name'] as String,
        icon: s['icon'] as IconData,
        imageGradient: (s['gradient'] as List).cast<Color>(),
        type: s['type'] as String,
        price: s['price'] as String,
      );
}