import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';

class MyCardsAndQrButtonsRow extends StatelessWidget {
  final VoidCallback onMyCardsTap;
  final VoidCallback onQrCodeTap;

  const MyCardsAndQrButtonsRow({
    super.key,
    required this.onMyCardsTap,
    required this.onQrCodeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PillButton(
            label: LocaleKeys.publish_qrCode.tr(),
            icon: AppImages.iconsQrCode,
            gradient: const LinearGradient(
              colors: [Color(0xFF17B78F), Color(0xFF2F6FED)],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
            onTap: onQrCodeTap,
          ),
        ),
        10.width,
        Expanded(
          child: _PillButton(
            label: LocaleKeys.publish_myCards.tr(),
            icon: AppImages.iconsCard,
            color: AppColors.blue.themeColor,
            onTap: onMyCardsTap,
          ),
        ),
      ],
    );
  }
}

class _PillButton extends StatelessWidget {
  final String label;
  final String icon;
  final Color? color;
  final Gradient? gradient;
  final VoidCallback onTap;

  const _PillButton({
    required this.label,
    required this.icon,
    this.color,
    this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            height: 15.w,
            width: 15.w,
            colorFilter: ColorFilter.mode(
              AppColors.white.themeColor,
              BlendMode.srcIn,
            ),
          ),
          8.width,
          AppText(
            label,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.white.themeColor,
          ),
        ],
      ),
    );
  }
}
