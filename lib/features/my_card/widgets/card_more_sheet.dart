import 'package:Silink/core/utils/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

Future<void> showCardMoreSheet(
  BuildContext context, {
  required String cardName,
  required VoidCallback onDuplicate,
  required VoidCallback onRename,
  required VoidCallback onTogglePause,
  required VoidCallback onDelete,
  required bool isPaused,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => Container(
      padding: EdgeInsets.fromLTRB(19.w, 10.h, 19.w, 24.h),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.borderColor.themeColor,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          16.height,
          AppText(cardName, fontSize: 14.sp, fontWeight: FontWeight.w700),
          16.height,
          _SheetItem(
            icon: Icons.copy_rounded,
            label: LocaleKeys.myCards_duplicate.tr(),
            onTap: onDuplicate,
          ),
          _SheetItem(
            icon: Icons.edit_outlined,
            label: LocaleKeys.myCards_rename.tr(),
            onTap: onRename,
          ),
          _SheetItem(
            icon: isPaused
                ? Icons.play_circle_outline
                : Icons.visibility_off_outlined,
            label: isPaused
                ? LocaleKeys.myCards_activate.tr()
                : LocaleKeys.myCards_pause.tr(),
            onTap: onTogglePause,
          ),
          _SheetItem(
            icon: Icons.delete_outline,
            label: LocaleKeys.myCards_delete.tr(),
            onTap: onDelete,
            color: Colors.red,
          ),
        ],
      ),
    ),
  );
}

class _SheetItem extends StatelessWidget {
  const _SheetItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            AppText(
              label,
              fontSize: 13.5.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
            const Spacer(),
            Icon(icon,
                size: 18.sp,
                color: color ?? AppColors.textSecondaryColor.themeColor),
          ],
        ),
      ),
    );
  }
}