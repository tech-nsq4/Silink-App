import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/locale_keys.dart';
import '../app_text.dart';
import 'public_profile_data.dart';
import 'public_profile_section_head.dart';

class PublicProfileConnect extends StatelessWidget {
  const PublicProfileConnect({
    super.key,
    required this.channels,
    required this.accent,
    required this.onTap,
  });

  final List<PublicProfileContact> channels;
  final Color accent;
  final ValueChanged<PublicProfileContact> onTap;

  IconData _iconOf(String type) => switch (type) {
        'whatsapp' => Icons.chat_bubble_outline_rounded,
        'linkedin' => Icons.business_center_outlined,
        'instagram' => Icons.camera_alt_outlined,
        _ => Icons.link_rounded,
      };

  @override
  Widget build(BuildContext context) {
    final tileWidth = (MediaQuery.sizeOf(context).width - 48.w - 18.w) / 3;
    return Padding(
      padding: EdgeInsets.only(bottom: 33.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PublicProfileSectionHead(
            eyebrow: LocaleKeys.publicProfile_connectEyebrow.tr(),
            title: LocaleKeys.publicProfile_connectTitle.tr(),
          ),
          Wrap(
            spacing: 9.w,
            runSpacing: 9.w,
            children: [
              for (final channel in channels)
                GestureDetector(
                  onTap: () => onTap(channel),
                  child: Container(
                    width: tileWidth,
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 15.h),
                    decoration: BoxDecoration(
                      color: AppColors.white.themeColor,
                      borderRadius: BorderRadius.circular(12.r),
                      border:
                          Border.all(color: AppColors.profileLine.themeColor),
                    ),
                    child: Column(
                      children: [
                        Icon(_iconOf(channel.type), size: 18.sp, color: accent),
                        SizedBox(height: 10.h),
                        AppText(
                          channel.label,
                          fontSize: 8.sp,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          color: AppColors.profileSocialLabel.themeColor,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
