import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PublicToggleCard extends StatefulWidget {
  const PublicToggleCard({super.key});

  @override
  State<PublicToggleCard> createState() => _PublicToggleCardState();
}

class _PublicToggleCardState extends State<PublicToggleCard> {
  bool _isPublic = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  LocaleKeys.publish_showToPublic.tr(),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
                2.height,
                AppText(
                  LocaleKeys.publish_showToPublicHint.tr(),
                  fontSize: 11.sp,
                  color: AppColors.textSecondaryColor.themeColor,
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.85,
            child: Switch(
              value: _isPublic,
              onChanged: (value) => setState(() => _isPublic = value),
              activeThumbColor: AppColors.mint.themeColor,
            ),
          ),
        ],
      ),
    );
  }
}
