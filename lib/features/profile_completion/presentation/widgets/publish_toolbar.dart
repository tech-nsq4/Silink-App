import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PublishToolbar extends StatelessWidget implements PreferredSizeWidget {
  const PublishToolbar({
    super.key,
    required this.onBack,
    required this.onSaveAndPublish,
    required this.onViewAsVisitor,
    required this.onCopyLink,
  });

  final VoidCallback onBack;
  final VoidCallback onSaveAndPublish;
  final VoidCallback onViewAsVisitor;
  final VoidCallback onCopyLink;

  @override
  Size get preferredSize => const Size.fromHeight(112);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        color: AppColors.white.themeColor,
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 10.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: onBack,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Row(
                    children: [
                      Icon(Icons.chevron_left,
                          size: 18.sp, color: const Color(0xFF8A8F98)),
                      AppText(
                        LocaleKeys.app_bar_back.tr(),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondaryColor.themeColor,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF17212B),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: AppText(
                    LocaleKeys.publish_previewEditor.tr(),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: onSaveAndPublish,
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF17B78F), Color(0xFF2368E2)],
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check, size: 14.sp, color: Colors.white),
                        4.width,
                        AppText(
                          LocaleKeys.publish_saveAndPublish.tr(),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            10.height,
            Row(
              children: [
                InkWell(
                  onTap: onCopyLink,
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.white.themeColor,
                      borderRadius: BorderRadius.circular(20.r),
                      border:
                          Border.all(color: AppColors.dividerColor.themeColor),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.ios_share,
                            size: 14.sp,
                            color: AppColors.textPrimaryColor.themeColor),
                        6.width,
                        AppText(
                          LocaleKeys.publish_copyLink.tr(),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                ),
                10.width,
                InkWell(
                  onTap: onViewAsVisitor,
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.mint.themeColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.visibility_outlined,
                            size: 14.sp, color: Colors.white),
                        6.width,
                        AppText(
                          LocaleKeys.publish_viewAsVisitor.tr(),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
