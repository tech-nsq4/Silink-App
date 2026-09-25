import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/profile_card/data/models/profile_card_contact_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCardLinkTile extends StatelessWidget {
  const ProfileCardLinkTile({
    super.key,
    required this.link,
    required this.primaryColor,
    required this.fontFamily,
    required this.onTap,
  });

  final ProfileCardContactItem link;
  final Color primaryColor;
  final String? fontFamily;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.dividerColor.themeColor),
        ),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.link_rounded, size: 18.sp, color: primaryColor),
            ),
            10.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    link.label,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: fontFamily,
                  ),
                  2.height,
                  AppText(
                    link.value.trim(),
                    fontSize: 11.sp,
                    color: AppColors.textSecondaryColor.themeColor,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_outward_rounded,
                size: 16.sp, color: AppColors.textSecondaryColor.themeColor),
          ],
        ),
      ),
    );
  }
}
