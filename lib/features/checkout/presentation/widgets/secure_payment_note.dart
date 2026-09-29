import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class SecurePaymentNote extends StatelessWidget {
  const SecurePaymentNote({super.key});

  @override
  Widget build(BuildContext context) {
    final color = AppColors.textSecondaryColor.themeColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.lock_outline_rounded, size: 14.sp, color: color),
        6.width,
        Flexible(
          child: AppText(
            LocaleKeys.store_secure_payment_note.tr(),
            fontSize: 11.sp,
            color: color,
          ),
        ),
      ],
    );
  }
}
