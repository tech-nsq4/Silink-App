import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/features/profile_completion/data/models/profile_completion_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/screen_header_bar.dart';
import 'widgets/how_to_share_info_box.dart';
import 'widgets/qr_display_card.dart';

class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({
    super.key,
    required this.data,
  });
  final ProfileCompletionData data;

  String get _fullLink {
    final handle = data.fullName.trim().isEmpty
        ? 'demo-profile'
        : data.fullName.trim().replaceAll(' ', '-');
    return 'silink.sa/$handle';
  }

  void _handleSimulateScan(BuildContext context) {
    NavigationService.push(
      Routes.publicProfilePreviewScreen,
      arguments: {'data': data},
    );
  }

  void _handleShare() {
    // TODO: hook up share_plus (Share.share('https://$_fullLink')).
    AppOverlay.showSuccess(LocaleKeys.common_comingSoon.tr());
  }

  void _handleCopyLink() {
    Clipboard.setData(ClipboardData(text: _fullLink));
    AppOverlay.showSuccess(LocaleKeys.publish_linkCopied.tr());
  }

  void _handleDownloadQr() {
    // TODO: capture the QrImageView via RepaintBoundary + save to gallery.
    AppOverlay.showSuccess(LocaleKeys.common_comingSoon.tr());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(
            title: LocaleKeys.qr_title.tr(),
            trailing: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppImages.iconsDownload),
            ),
          ),
          12.height,
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 19.w),
              child: Column(
                children: [
                  QrDisplayCard(
                    name: data.fullName,
                    jobTitle: data.jobTitle,
                    initial: data.fullName.initial,
                    fullLink: _fullLink,
                  ),
                  12.height,
                  CustomButton(
                    onTap: () => _handleSimulateScan(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppImages.iconsPreview,
                          colorFilter: ColorFilter.mode(
                            AppColors.white.themeColor,
                            BlendMode.srcIn,
                          ),
                          height: 16.h,
                          width: 16.w,
                        ),
                        8.width,
                        AppText(
                          LocaleKeys.qr_simulateScan.tr(),
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  12.height,
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          onTap: _handleCopyLink,
                          isOutlined: true,
                          borderColor: AppColors.borderColor.themeColor,
                          height: 44.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.link,
                                size: 14.h,
                                color: AppColors.textPrimaryColor.themeColor,
                              ),
                              8.width,
                              AppText(
                                LocaleKeys.publish_copyLink.tr(),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimaryColor.themeColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      10.width,
                      Expanded(
                        child: CustomButton(
                          onTap: _handleShare,
                          isOutlined: true,
                          borderColor: AppColors.borderColor.themeColor,
                          height: 44.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppImages.iconsShare,
                                height: 14.h,
                              ),
                              8.width,
                              AppText(LocaleKeys.publish_share.tr(),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimaryColor.themeColor),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  10.height,
                  CustomButton(
                    onTap: _handleDownloadQr,
                    isOutlined: true,
                    borderColor: AppColors.borderColor.themeColor,
                    height: 44.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppImages.iconsDownload,
                          height: 15.h,
                        ),
                        8.width,
                        AppText(
                          LocaleKeys.qr_downloadQr.tr(),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                  16.height,
                  const HowToShareInfoBox(),
                  16.height,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
