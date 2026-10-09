import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/convert_helper.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/studio_draft.dart';

class StudioLiveIdentity extends StatelessWidget {
  const StudioLiveIdentity({super.key, required this.draft});

  final StudioDraft draft;

  @override
  Widget build(BuildContext context) {
    final accent = ConvertHelper.hexToColor(draft.primaryColor);
    final name = draft.name.trim();
    final title = draft.title.trim();
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(13.r),
        border: Border.all(color: AppColors.studioIdentityBorder.themeColor),
      ),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 38.w,
            height: 38.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(11.r),
            ),
            child: AppText(
              draft.initials.isEmpty
                  ? LocaleKeys.publicProfile_you.tr()
                  : draft.initials,
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.white.light,
            ),
          ),
          10.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  name.isEmpty
                      ? LocaleKeys.cardStudio_liveNamePlaceholder.tr()
                      : name,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 3.h),
                AppText(
                  title.isEmpty
                      ? LocaleKeys.cardStudio_liveTitlePlaceholder.tr()
                      : title,
                  fontSize: 9.sp,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  color: AppColors.studioEditorSubtitle.themeColor,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: 5.w,
                height: 5.w,
                decoration: BoxDecoration(
                  color: AppColors.studioLiveDot.themeColor,
                  shape: BoxShape.circle,
                ),
              ),
              5.width,
              AppText(
                LocaleKeys.cardStudio_liveBadge.tr(),
                fontSize: 8.sp,
                color: AppColors.studioLivePreviewText.themeColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
