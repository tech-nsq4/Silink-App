import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';

enum CompanyCatalogItemAction { edit, toggleVisibility, delete }

class CatalogItemManageButton extends StatelessWidget {
  const CatalogItemManageButton({
    super.key,
    required this.visible,
    required this.onSelected,
  });

  final bool visible;
  final ValueChanged<CompanyCatalogItemAction> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CompanyCatalogItemAction>(
      tooltip: LocaleKeys.company_manage_item.tr(),
      color: AppColors.cardColor.themeColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      icon: Icon(
        Icons.more_horiz_rounded,
        size: 20.sp,
        color: AppColors.textPrimaryColor.themeColor,
      ),
      onSelected: onSelected,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: CompanyCatalogItemAction.edit,
          child: _MenuLabel(
            icon: Icons.edit_outlined,
            label: LocaleKeys.company_edit_item_title.tr(),
          ),
        ),
        PopupMenuItem(
          value: CompanyCatalogItemAction.toggleVisibility,
          child: _MenuLabel(
            icon: visible
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            label: visible
                ? LocaleKeys.company_hide_item.tr()
                : LocaleKeys.company_show_item.tr(),
          ),
        ),
        PopupMenuItem(
          value: CompanyCatalogItemAction.delete,
          child: _MenuLabel(
            icon: Icons.delete_outline_rounded,
            label: LocaleKeys.company_delete_item.tr(),
            color: AppColors.errorColor.themeColor,
          ),
        ),
      ],
    );
  }
}

class _MenuLabel extends StatelessWidget {
  const _MenuLabel({
    required this.icon,
    required this.label,
    this.color,
  });

  final IconData icon;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final foreground = color ?? AppColors.textPrimaryColor.themeColor;
    return Row(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(end: 8.h),
          child: Icon(icon, size: 18.sp, color: foreground),
        ),
        AppText(
          label,
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          color: foreground,
        ),
      ],
    );
  }
}
