import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:Silink/features/my_card/models/my_card_model.dart';


// ─── Actions card: preview / QR / share ─────────────────────────────────────

class ActionsCard extends StatelessWidget {
  const ActionsCard({super.key,
    required this.onPreview,
    required this.onQr,
    required this.onShare,
  });

  final VoidCallback onPreview;
  final VoidCallback onQr;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ActionItem(
              icon: AppImages.iconsPreview,
              label: LocaleKeys.myCards_preview.tr(),
              onTap: onPreview,
            ),
          ),
          Expanded(
            child: _ActionItem(
              icon: AppImages.iconsQrCode,
              label: LocaleKeys.myCards_qr.tr(),
              onTap: onQr,
            ),
          ),
          Expanded(
            child: _ActionItem(
              icon: AppImages.iconsShare,
              label: LocaleKeys.myCards_share.tr(),
              onTap: onShare,
            ),
          ),
        ],
      ),
    );
  }
}

/// Simple icon-over-label action (matches design: no colored circle, no title).
class _ActionItem extends StatelessWidget {
  const _ActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final String icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
              width: 22.sp,
              height: 22.sp,
              colorFilter: ColorFilter.mode(
                AppColors.textPrimaryColor.themeColor,
                BlendMode.srcIn,
              ),
            ),
            8.height,
            AppText(
              label,
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Publish status (status + link) ─────────────────────────────────────────

class PublishStatusCard extends StatelessWidget {
  const PublishStatusCard({
    super.key,
    required this.card,
    required this.onCopy,
  });

  final MyCardModel card;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final isPublished = card.isPublished;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.public_rounded,
                    size: 16.sp,
                    color: AppColors.textSecondaryColor.themeColor,
                  ),
                  6.width,
                  AppText(
                    LocaleKeys.myCards_publishStatus.tr(),
                    fontSize: 12.sp,
                    color: AppColors.textSecondaryColor.themeColor,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isPublished
                      ? const Color(0xFFE7F8F0)
                      : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: AppText(
                  isPublished
                      ? LocaleKeys.myCards_isPublished.tr()
                      : LocaleKeys.myCards_notPublished.tr(),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  color: isPublished
                      ? const Color(0xFF17B78F)
                      : AppColors.textSecondaryColor.themeColor,
                ),
              ),
            ],
          ),
          12.height,
          Divider(height: 1, color: AppColors.borderColor.themeColor),
          12.height,
          Row(
            children: [
              Expanded(
                child: AppText(
                  card.link,
                  fontSize: 12.sp,
                  color: AppColors.textPrimaryColor.themeColor,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              8.width,
              InkWell(
                onTap: onCopy,
                borderRadius: BorderRadius.circular(8.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: AppText(
                    LocaleKeys.publish_copy.tr(),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF17B78F),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── NFC card ───────────────────────────────────────────────────────────────

class NfcCard extends StatelessWidget {
  const NfcCard({super.key, required this.card});

  final MyCardModel card;

  @override
  Widget build(BuildContext context) {
    final statusText = card.nfcActive
        ? LocaleKeys.myCards_nfcEnabled.tr()
        : LocaleKeys.myCards_nfcDisabled.tr();
    final code = card.nfcCardCode?.trim() ?? '';
    final subtitle = code.isEmpty ? statusText : '$code · $statusText';
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFE7F8F0),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.nfc_rounded,
                  size: 20.sp,
                  color: const Color(0xFF17B78F),
                ),
              ),
              10.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    LocaleKeys.myCards_nfcPremium.tr(),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  3.height,
                  AppText(
                    subtitle,
                    fontSize: 10.5.sp,
                    color: AppColors.textSecondaryColor.themeColor,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: card.nfcActive
                  ? const Color(0xFFE7F8F0)
                  : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: AppText(
              card.nfcActive
                  ? LocaleKeys.myCards_statusActive.tr()
                  : LocaleKeys.myCards_nfcDisabled.tr(),
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: card.nfcActive
                  ? const Color(0xFF17B78F)
                  : AppColors.textSecondaryColor.themeColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Stats card ─────────────────────────────────────────────────────────────

class StatsCard extends StatelessWidget {
  const StatsCard({super.key,
    required this.visitsCount,
    required this.clientsCount,
    required this.lastUpdated,
  });

  final int visitsCount;
  final int clientsCount;
  final String lastUpdated;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              Icons.remove_red_eye_outlined,
              visitsCount.toString(),
              LocaleKeys.myCards_visitsCount.tr(),
            ),
          ),
          Expanded(
            child: _buildStatItem(
              Icons.people_outline,
              clientsCount.toString(),
              LocaleKeys.myCards_clientsCount.tr(),
            ),
          ),
          Expanded(
            child: _buildStatItem(
              Icons.calendar_today_outlined,
              lastUpdated,
              LocaleKeys.myCards_statsLastUpdate.tr(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: AppColors.textPrimaryColor.themeColor,
        ),
        6.height,
        AppText(
          value,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          textAlign: TextAlign.center,
        ),
        4.height,
        AppText(
          label,
          fontSize: 10.sp,
          color: AppColors.textSecondaryColor.themeColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
