import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../logic/company_cubit.dart';
import 'company_field.dart';

class CompanyStepOne extends StatelessWidget {
  const CompanyStepOne({
    super.key,
    required this.nameCtrl,
    required this.regCtrl,
    required this.taxCtrl,
    required this.descCtrl,
    required this.emailCtrl,
    required this.onNameChanged,
  });

  final TextEditingController nameCtrl;
  final TextEditingController regCtrl;
  final TextEditingController taxCtrl;
  final TextEditingController descCtrl;
  final TextEditingController emailCtrl;

  final VoidCallback onNameChanged;

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
                child: Center(
                  child: AppText(
                    nameCtrl.text.trim().isEmpty
                        ? 'Q'
                        : nameCtrl.text.trim().substring(0, 1),
                    fontSize: 34.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mint.themeColor,
                  ),
                ),
              ),
              PositionedDirectional(
                end: 0,
                bottom: 0,
                child: InkWell(
                  onTap: () =>
                      AppOverlay.showSuccess(LocaleKeys.common_comingSoon.tr()),
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
          validator: (value) => CompanyCubit.requiredValidator(value)?.tr(),
          onChanged: (_) => onNameChanged(),
        ),
        12.height,
        CompanyField(
          label: LocaleKeys.company_registration.tr(),
          hint: LocaleKeys.company_registration_hint.tr(),
          controller: regCtrl,
          keyboardType: TextInputType.number,
          validator: (value) => CompanyCubit.requiredValidator(value)?.tr(),
        ),
        12.height,
        CompanyField(
          label: LocaleKeys.company_tax.tr(),
          hint: LocaleKeys.company_tax_hint.tr(),
          controller: taxCtrl,
          keyboardType: TextInputType.number,
        ),
        12.height,
        CompanyField(
          label: LocaleKeys.company_activity.tr(),
          hint: LocaleKeys.company_activity_hint.tr(),
          controller: descCtrl,
          maxLines: 3,
        ),
        12.height,
        CompanyField(
          label: LocaleKeys.company_email.tr(),
          hint: LocaleKeys.company_email_hint.tr(),
          controller: emailCtrl,
          keyboardType: TextInputType.emailAddress,
          validator: (value) => CompanyCubit.emailValidator(value)?.tr(),
        ),
      ],
    );
  }
}
