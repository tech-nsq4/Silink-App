import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/notifications/widgets/menu_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../../account/widgets/account_toggle_tile.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  void _save(BuildContext context) {
    // Notification preferences are stored locally on the device only.
    AppOverlay.showSuccess(LocaleKeys.stats_saved.tr());
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(
            title: LocaleKeys.account_notificationsTitle.tr(),
            trailing: InkWell(
              onTap: () => _save(context),
              child: Container(
                padding: 16.paddingHorizontal + 4.paddingVert,
                decoration: BoxDecoration(
                  color:
                      AppColors.successColor.themeColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: AppText(
                  LocaleKeys.stats_saved.tr(),
                  color: AppColors.successColor.themeColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MenuNotifications(
                    children: [
                      AccountToggleTile(
                        title: LocaleKeys.account_offersTitle.tr(),
                        subtitle: LocaleKeys.account_offersSubtitle.tr(),
                        initiallyEnabled: true,
                      ),
                      AccountToggleTile(
                        title: LocaleKeys.account_remindersTitle.tr(),
                        subtitle: LocaleKeys.account_remindersSubtitle.tr(),
                      ),
                      AccountToggleTile(
                        title: LocaleKeys.account_followersTitle.tr(),
                        subtitle: LocaleKeys.account_followersSubtitle.tr(),
                        initiallyEnabled: true,
                      ),
                      AccountToggleTile(
                        title: LocaleKeys.account_nfcTitle.tr(),
                        subtitle: LocaleKeys.account_nfcSubtitle.tr(),
                        initiallyEnabled: true,
                      ),
                      AccountToggleTile(
                        title: LocaleKeys.account_messagesTitle.tr(),
                        subtitle: LocaleKeys.account_messagesSubtitle.tr(),
                      ),
                      AccountToggleTile(
                        title: LocaleKeys.account_reportsTitle.tr(),
                        subtitle: LocaleKeys.account_reportsSubtitle.tr(),
                      ),
                    ],
                  ),
                  16.height,
                  AppText(
                    LocaleKeys.account_notificationsNote.tr(),
                    fontSize: 12.sp,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
