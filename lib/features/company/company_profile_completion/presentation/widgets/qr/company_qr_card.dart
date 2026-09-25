import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/company/widgets/qr/company_qr_link_pill.dart';

class CompanyQrCard extends StatelessWidget {
  const CompanyQrCard({
    super.key,
    required this.companyName,
    required this.qrData,
    required this.link,
    this.onLinkTap,
  });

  final String companyName;
  final String qrData;
  final String link;
  final VoidCallback? onLinkTap;

  String get _initials {
    final words = companyName
        .trim()
        .split(' ')
        .where((word) => word.trim().isNotEmpty)
        .take(2)
        .toList();
    if (words.isEmpty) return '';
    return words.map((word) => word.trim()[0]).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 22.h),
      decoration: BoxDecoration(
        color: AppColors.cardColor.themeColor,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.themeColor.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 54.w,
            height: 54.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.companyBrand.themeColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: AppText(
              _initials,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.overlayOnDark.themeColor,
            ),
          ),
          12.height,
          AppText(
            companyName,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
          4.height,
          AppText(
            LocaleKeys.company_qr_page_subtitle.tr(),
            fontSize: 12.sp,
            color: AppColors.textSecondaryColor.themeColor,
            textAlign: TextAlign.center,
          ),
          18.height,
          QrImageView(
            data: qrData,
            version: QrVersions.auto,
            size: 200.w,
            backgroundColor: Colors.white,
            eyeStyle: QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: AppColors.companyBrand.themeColor,
            ),
            dataModuleStyle: QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: AppColors.dropdownSurface.themeColor,
            ),
          ),
          18.height,
          CompanyQrLinkPill(
            link: link,
            onTap: onLinkTap,
          ),
        ],
      ),
    );
  }
}
