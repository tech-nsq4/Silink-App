import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_tap_effect.dart';
import '../../../../core/widgets/gradient_action_button.dart';

class ClientInlineActions extends StatelessWidget {
  const ClientInlineActions({
    super.key,
    required this.saveLabel,
    required this.onSave,
    required this.onCancel,
  });

  final String saveLabel;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GradientActionButton(
            title: saveLabel,
            centerTitle: true,
            radius: 14,
            minHeight: 46,
            onTap: onSave,
          ),
        ),
        12.width,
        Expanded(
          child: CustomTapEffect(
            onTap: onCancel,
            child: Container(
              height: 50.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.white.themeColor,
                borderRadius: BorderRadius.circular(14.r),
                border:
                    Border.all(color: AppColors.studioPanelBorder.themeColor),
              ),
              child: AppText(
                LocaleKeys.clientsHub_cancel.tr(),
                fontSize: 11.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
