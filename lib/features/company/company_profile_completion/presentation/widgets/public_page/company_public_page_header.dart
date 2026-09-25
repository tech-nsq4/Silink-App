import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';

class CompanyPublicPageHeader extends StatelessWidget {
  const CompanyPublicPageHeader({
    super.key,
    required this.companyName,
    this.industry,
    this.city,
    this.employeesLabel,
    this.imagePath,
  });

  final String companyName;
  final String? industry;
  final String? city;
  final String? employeesLabel;
  final String? imagePath;

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

  String get _meta => [industry, city]
      .where((value) => value != null && value.trim().isNotEmpty)
      .join(' · ');

  @override
  Widget build(BuildContext context) {
    final brand = AppColors.companyBrand.themeColor;
    final hasEmployees = employeesLabel != null && employeesLabel!.isNotEmpty;
    final hasImage = imagePath != null && imagePath!.trim().isNotEmpty;
    final fallback = AppText(
      _initials,
      fontSize: 22.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.overlayOnDark.themeColor,
    );

    return Column(
      children: [
        Container(
          width: 72.w,
          height: 72.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: brand,
            borderRadius: BorderRadius.circular(22.r),
            border: Border.all(
              color: AppColors.backgroundColor.themeColor,
              width: 4.w,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: hasImage
              ? Image.file(
                  File(imagePath!),
                  width: 72.w,
                  height: 72.w,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => fallback,
                )
              : fallback,
        ),
        12.height,
        AppText(
          companyName,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          textAlign: TextAlign.center,
        ),
        if (_meta.isNotEmpty) ...[
          6.height,
          AppText(
            _meta,
            fontSize: 12.sp,
            color: AppColors.textSecondaryColor.themeColor,
            textAlign: TextAlign.center,
          ),
        ],
        if (hasEmployees) ...[
          4.height,
          AppText(
            '${employeesLabel!.trim()} ${LocaleKeys.company_employee_word.tr()}',
            fontSize: 10.sp,
            color: AppColors.textSecondaryColor.themeColor,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
