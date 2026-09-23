import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../models/client_model.dart';
import 'status_badge.dart';

class ClientTile extends StatelessWidget {
  const ClientTile({super.key, required this.client, required this.onTap});

  final ClientModel client;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final company = (client.company ?? '').trim();
    final secondary = AppColors.textSecondaryColor.themeColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.borderColor.themeColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: AppText(
                          client.name,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      8.width,
                      const DemoDataBadge(),
                    ],
                  ),
                ),
                8.width,
                StatusBadge(status: client.status),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (company.isNotEmpty) ...[
                  6.height,
                  AppText(
                    company,
                    fontSize: 12.sp,
                    color: secondary,
                    maxLines: 1,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                5.height,
                AppText(
                  client.phone,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondaryColor.themeColor,
                ),
              ],
            ),
            12.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: SourceTag(source: client.source)),
                Flexible(
                  child: AppText(
                    client.timeLabel,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: secondary,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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

class DemoDataBadge extends StatelessWidget {
  const DemoDataBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: AppColors.infoCardBackground.themeColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: AppText(
        LocaleKeys.clients_sourceLabel.tr(),
        fontSize: 10.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.infoCardIcon.themeColor,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class SourceTag extends StatelessWidget {
  const SourceTag({super.key, required this.source});

  final ClientSource source;

  @override
  Widget build(BuildContext context) {
    final secondary = AppColors.textSecondaryColor.themeColor;
    final isQr = source == ClientSource.qr;
    final label = isQr ? LocaleKeys.clients_sourceQr.tr() : 'NFC';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          isQr ? AppImages.iconsQrCode : AppImages.iconsWifi,
          width: 13.w,
          height: 13.w,
          colorFilter: ColorFilter.mode(secondary, BlendMode.srcIn),
        ),
        4.width,
        Flexible(
          child: AppText(
            label,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: secondary,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
