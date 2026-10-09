import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import 'studio_input.dart';
import 'studio_toggle.dart';

class StudioSocialField extends StatelessWidget {
  const StudioSocialField({
    super.key,
    required this.label,
    required this.visible,
    required this.controller,
    required this.onToggle,
    required this.onChanged,
  });

  final String label;
  final bool visible;
  final TextEditingController controller;
  final ValueChanged<bool> onToggle;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.studioIdentityBorder.themeColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(label, fontSize: 11.sp, fontWeight: FontWeight.w700),
              StudioToggle(value: visible, onChanged: onToggle),
            ],
          ),
          if (visible) ...[
            SizedBox(height: 12.h),
            StudioInput(
              controller: controller,
              hint: LocaleKeys.cardStudio_socialHint.tr(),
              onChanged: onChanged,
              ltr: true,
            ),
          ],
        ],
      ),
    );
  }
}
