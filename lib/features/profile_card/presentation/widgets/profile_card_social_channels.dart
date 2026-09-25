import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/profile_card/data/models/profile_card_contact_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCardSocialChannels extends StatelessWidget {
  const ProfileCardSocialChannels({
    super.key,
    required this.channels,
    required this.primaryColor,
    required this.fontFamily,
    required this.onTap,
  });

  final List<ProfileCardContactItem> channels;
  final Color primaryColor;
  final String? fontFamily;
  final ValueChanged<ProfileCardContactItem> onTap;

  static String _badgeOf(String type) => switch (type) {
        'instagram' => 'IG',
        'linkedin' => 'in',
        'snapchat' => 'SC',
        'tiktok' => 'TT',
        'x' => 'X',
        _ => '#',
      };

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8.w,
      runSpacing: 8.h,
      children: [
        for (final channel in channels)
          InkWell(
            onTap: () => onTap(channel),
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              padding: EdgeInsetsDirectional.fromSTEB(6.w, 6.h, 12.w, 6.h),
              decoration: BoxDecoration(
                color: AppColors.white.themeColor,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: AppColors.dividerColor.themeColor),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 24.w,
                    height: 24.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: AppText(
                      _badgeOf(channel.type),
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w800,
                      color: primaryColor,
                    ),
                  ),
                  6.width,
                  AppText(
                    channel.label,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: fontFamily,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
