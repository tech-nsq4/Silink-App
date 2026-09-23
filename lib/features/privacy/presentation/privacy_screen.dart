import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../../account/widgets/account_toggle_tile.dart';
import '../widgets/account_group_card.dart';
import '../widgets/account_row_tile.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(title: LocaleKeys.account_privacyTitle.tr()),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AccountGroupCard(
                    children: [
                      AccountRowTile(
                        icon: AppImages.iconsLock,
                        label: LocaleKeys.account_passwordTitle.tr(),
                        trailing: _TextAction(
                          label: LocaleKeys.account_change.tr(),
                          onTap: _comingSoon,
                        ),
                      ),
                      Divider(color: AppColors.borderColor.themeColor),
                      AccountToggleTile(
                        leading: _icon(AppImages.iconsPrivacy),
                        title: LocaleKeys.account_twoStep.tr(),
                        enabledSubtitle: LocaleKeys.account_enabled.tr(),
                        disabledSubtitle: LocaleKeys.account_disabled.tr(),
                      ),
                    ],
                  ),
                  12.height,
                  // ─── Profile visibility ────────────────────────────────
                  AccountGroupCard(
                    children: [
                      AccountToggleTile(
                        leading: _icon(AppImages.iconsPreview),
                        title: LocaleKeys.account_profileVisibility.tr(),
                        subtitle: LocaleKeys.account_publicVisibility.tr(),
                        initiallyEnabled: true,
                      ),
                    ],
                  ),
                  20.height,
                  // ─── Active devices ────────────────────────────────────
                  _SectionTitle(LocaleKeys.account_activeDevices.tr()),
                  10.height,
                  AccountGroupCard(
                    children: [
                      for (final device in _devices) _deviceTile(device),
                    ],
                  ),
                  12.height,
                  
                  _LogoutAllButton(onTap: _comingSoon),
                  22.height,
                  // ─── Data & account ────────────────────────────────────
                  _SectionTitle(LocaleKeys.account_dataAndAccount.tr()),
                  10.height,
                  AccountGroupCard(
                    children: [
                      AccountRowTile(
                        icon: AppImages.iconsDownload,
                        label: LocaleKeys.account_downloadMyData.tr(),
                        showChevron: true,
                        onTap: _comingSoon,
                      ),
                      Divider(color: AppColors.borderColor.themeColor),
                      AccountRowTile(
                        icon: AppImages.iconsDelete,
                        iconColor: AppColors.saleRed.themeColor,
                        label: LocaleKeys.account_deleteAccount.tr(),
                        showChevron: true,
                        onTap: _comingSoon,
                      ),
                    ],
                  ),
                  24.height,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _comingSoon() =>
      AppOverlay.showSuccess(LocaleKeys.common_comingSoon.tr());

  Widget _icon(String path) => SvgPicture.asset(path, height: 18.h);

  Widget _deviceTile(_DeviceMock device) {
    return AccountRowTile(
      icon: AppImages.iconsWifi,
      label: device.name,
      subtitle: device.meta,
      trailing: _TextAction(
        label: device.current
            ? LocaleKeys.account_currentDevice.tr()
            : LocaleKeys.account_deviceLogout.tr(),
        color: device.current
            ? AppColors.successColor.themeColor
            : AppColors.saleRed.themeColor,
        onTap: device.current ? null : _comingSoon,
      ),
    );
  }
}


class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 4.w),
      child: AppText(
        title,
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}


class _TextAction extends StatelessWidget {
  const _TextAction({
    required this.label,
    this.color,
    this.onTap,
  });

  final String label;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final text = AppText(
      label,
      fontSize: 12.sp,
      fontWeight: FontWeight.w700,
      color: color ?? AppColors.successColor.themeColor,
    );

    if (onTap == null) return text;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        child: text,
      ),
    );
  }
}

/// Soft red button used to sign out of every other active session.
class _LogoutAllButton extends StatelessWidget {
  const _LogoutAllButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.saleRedSoft.themeColor,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: AppColors.saleRed.themeColor.withValues(alpha: 0.25),
          ),
        ),
        child: AppText(
          LocaleKeys.account_logoutOtherDevices.tr(),
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.saleRed.themeColor,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

/// Demo row for the active sessions list — to be replaced by the real API.
class _DeviceMock {
  const _DeviceMock(this.name, this.meta, {this.current = false});

  final String name;
  final String meta;
  final bool current;
}

const List<_DeviceMock> _devices = [
  _DeviceMock('iPhone 14 Pro', 'الرياض — الآن', current: true),
  _DeviceMock('MacBook Pro', 'جدة — منذ 3 أيام'),
  _DeviceMock('Samsung Galaxy S23', 'غير معروف — منذ أسبوع'),
];
