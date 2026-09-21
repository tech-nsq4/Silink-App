import 'package:Silink/core/utils/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class CardActionBar extends StatelessWidget {
  const CardActionBar({
    super.key,
    required this.onMoreTap,
    required this.onQrTap,
    required this.onPreviewTap,
    required this.onEditTap,
  });

  final VoidCallback onMoreTap;
  final VoidCallback onQrTap;
  final VoidCallback onPreviewTap;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _ActionItem(
            icon: Icons.edit_outlined,
            label: LocaleKeys.myCards_edit.tr(),
            onTap: onEditTap),
        _divider(),
        _ActionItem(
            icon: Icons.remove_red_eye_outlined,
            label: LocaleKeys.myCards_preview.tr(),
            onTap: onPreviewTap),
        _divider(),
        _ActionItem(
            icon: Icons.qr_code_rounded,
            label: LocaleKeys.myCards_qr.tr(),
            onTap: onQrTap),
        _divider(),
        _ActionItem(
            icon: Icons.more_horiz,
            label: LocaleKeys.myCards_more.tr(),
            onTap: onMoreTap),
      ],
    );
  }

  Widget _divider() => Container(
        width: 1,
        height: 40.h,
        color: AppColors.borderColor.themeColor,
      );
}

class _ActionItem extends StatelessWidget {
  const _ActionItem(
      {required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 40.h,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 17.sp, color: AppColors.textSecondaryColor.themeColor),
              SizedBox(height: 3.h),
              AppText(label,
                  fontSize: 10.5.sp,
                  color: AppColors.textSecondaryColor.themeColor),
            ],
          ),
        ),
      ),
    );
  }
}
