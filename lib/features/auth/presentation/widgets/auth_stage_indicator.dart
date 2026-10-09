import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class AuthStageIndicator extends StatelessWidget {
  const AuthStageIndicator({super.key, required this.step, this.onDetailsTap});

  final int step;
  final VoidCallback? onDetailsTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: step > 0 ? onDetailsTap : null,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: _label(LocaleKeys.auth_stageDetails.tr(), step == 0),
          ),
        ),
        10.width,
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.borderColor.themeColor,
          ),
        ),
        10.width,
        _label(LocaleKeys.auth_stageSecurity.tr(), step == 1),
      ],
    );
  }

  Widget _label(String text, bool active) => AppText(
        text,
        fontSize: 9.sp,
        fontWeight: active ? FontWeight.w700 : FontWeight.w400,
        color: active
            ? AppColors.accentTeal.themeColor
            : AppColors.tabInactive.themeColor,
      );
}
