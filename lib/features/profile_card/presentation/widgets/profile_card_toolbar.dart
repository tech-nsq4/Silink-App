import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'profile_card_toolbar_pill.dart';

class ProfileCardToolbar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProfileCardToolbar({
    super.key,
    required this.onBack,
    required this.onOpenEditor,
    required this.onSaveAndPublish,
    required this.onViewAsVisitor,
    required this.onCopyLink,
  });

  final VoidCallback onBack;
  final VoidCallback onOpenEditor;
  final VoidCallback onSaveAndPublish;
  final VoidCallback onViewAsVisitor;
  final VoidCallback onCopyLink;

  @override
  Size get preferredSize => Size.fromHeight(118.h);

  @override
  Widget build(BuildContext context) {
    final mint = AppColors.mint.themeColor;
    final mutedText = AppColors.profileCardToolbarText.themeColor;

    return Container(
      color: AppColors.profileCardToolbar.themeColor,
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 10.h),
              child: Row(
                children: [
                  InkWell(
                    onTap: onBack,
                    borderRadius: BorderRadius.circular(8.r),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back_ios_new_rounded,
                              size: 14.sp, color: mutedText),
                          6.width,
                          AppText(
                            LocaleKeys.app_bar_back.tr(),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: mutedText,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: onOpenEditor,
                    borderRadius: BorderRadius.circular(20.r),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: AppColors.profileCardToolbarChip.themeColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.edit_rounded,
                              size: 13.sp,
                              color: AppColors.accentGold.themeColor),
                          6.width,
                          AppText(
                            LocaleKeys.publish_previewEditor.tr(),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: mutedText,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: onSaveAndPublish,
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        gradient: LinearGradient(
                          colors: [mint, AppColors.blue.themeColor],
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_rounded,
                              size: 15.sp, color: AppColors.white.themeColor),
                          6.width,
                          AppText(
                            LocaleKeys.publish_saveAndPublish.tr(),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.white.themeColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.profileCardToolbarChip.themeColor,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileCardToolbarPill(
                    icon: Icons.visibility_outlined,
                    label: LocaleKeys.publish_viewAsVisitor.tr(),
                    color: mint,
                    onTap: onViewAsVisitor,
                  ),
                  10.width,
                  ProfileCardToolbarPill(
                    icon: Icons.share_outlined,
                    label: LocaleKeys.publish_copyLink.tr(),
                    color: mutedText,
                    borderColor: AppColors.profileCardToolbarBorder.themeColor,
                    onTap: onCopyLink,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
