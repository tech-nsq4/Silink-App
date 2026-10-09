import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extensions/extensions.dart';
import '../../utils/app_colors.dart';
import '../../utils/locale_keys.dart';
import '../app_text.dart';
import 'public_profile_data.dart';
import 'public_profile_section_head.dart';

class PublicProfileLinks extends StatelessWidget {
  const PublicProfileLinks({
    super.key,
    required this.links,
    required this.accent,
    required this.onTap,
  });

  final List<PublicProfileContact> links;
  final Color accent;
  final ValueChanged<PublicProfileContact> onTap;

  IconData _iconOf(String type) => switch (type) {
        'booking' => Icons.calendar_today_outlined,
        'portfolio' => Icons.work_outline_rounded,
        'quote' => Icons.request_quote_outlined,
        'profile' => Icons.description_outlined,
        _ => Icons.language_rounded,
      };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 25.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PublicProfileSectionHead(
            eyebrow: LocaleKeys.publicProfile_linksEyebrow.tr(),
            title: LocaleKeys.publicProfile_linksTitle.tr(),
          ),
          for (final link in links)
            GestureDetector(
              onTap: () => onTap(link),
              child: Container(
                margin: EdgeInsets.only(bottom: 9.h),
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  color: AppColors.white.themeColor,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.profileLine.themeColor),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 34.w,
                      height: 34.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.profileResourceIcon.themeColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child:
                          Icon(_iconOf(link.type), size: 18.sp, color: accent),
                    ),
                    11.width,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            link.label,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.profileResourceTitle.themeColor,
                          ),
                          SizedBox(height: 5.h),
                          AppText(
                            link.host,
                            fontSize: 8.sp,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.profileResourceHost.themeColor,
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.north_west_rounded,
                        size: 17.sp,
                        color: AppColors.profileResourceArrow.themeColor),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
