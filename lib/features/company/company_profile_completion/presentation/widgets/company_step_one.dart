import 'dart:io';

import 'package:Silink/features/company/company_profile_completion/presentation/widgets/company_validators.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/company/shared/widgets/company_field.dart';

class CompanyStepOne extends StatelessWidget {
  const CompanyStepOne({
    super.key,
    required this.nameCtrl,
    required this.bioCtrl,
    required this.websiteCtrl,
    required this.logoUrl,
    required this.logoFile,
    required this.onPickLogo,
    required this.onNameChanged,
  });

  final TextEditingController nameCtrl;
  final TextEditingController bioCtrl;
  final TextEditingController websiteCtrl;
  final String? logoUrl;
  final File? logoFile;
  final VoidCallback onPickLogo;

  final VoidCallback onNameChanged;

  static const _bioMaxLength = 200;

  Widget _avatar() {
    if (logoFile != null) {
      return Image.file(logoFile!, fit: BoxFit.cover);
    }
    if (logoUrl != null && logoUrl!.isNotEmpty) {
      return Image.network(
        logoUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _fallback(),
      );
    }
    return _fallback();
  }

  Widget _fallback() {
    final name = nameCtrl.text.trim();
    return Center(
      child: name.isEmpty
          ? Icon(Icons.business_rounded,
              size: 36.sp, color: AppColors.mint.themeColor)
          : AppText(
              name.substring(0, 1).toUpperCase(),
              fontSize: 34.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.mint.themeColor,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Stack(
            children: [
              Container(
                width: 88.w,
                height: 88.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.mintSoft.themeColor,
                  border:
                      Border.all(color: AppColors.mint.themeColor, width: 2),
                ),
                child: ClipOval(child: _avatar()),
              ),
              PositionedDirectional(
                end: 0,
                bottom: 0,
                child: InkWell(
                  onTap: onPickLogo,
                  child: Container(
                    padding: EdgeInsets.all(7.w),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.mint.themeColor),
                    child: Icon(Icons.camera_alt_rounded,
                        size: 14.sp, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        8.height,
        Center(
          child: AppText(
            LocaleKeys.company_logo_hint.tr(),
            fontSize: 12.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
        ),
        16.height,
        CompanyField(
          label: LocaleKeys.company_name.tr(),
          hint: LocaleKeys.company_name_hint.tr(),
          controller: nameCtrl,
          required: true,
          validator: (value) =>
              CompanyValidators.requiredValidator(value)?.tr(),
          onChanged: (_) => onNameChanged(),
        ),
        12.height,
        CompanyField(
          label: LocaleKeys.company_bio.tr(),
          hint: LocaleKeys.company_bio_hint.tr(),
          controller: bioCtrl,
          maxLines: 3,
          maxLength: _bioMaxLength,
          onChanged: (_) => onNameChanged(),
        ),
        12.height,
        CompanyField(
          label: LocaleKeys.company_website.tr(),
          hint: LocaleKeys.company_website_hint.tr(),
          controller: websiteCtrl,
          keyboardType: TextInputType.url,
        ),
      ],
    );
  }
}
