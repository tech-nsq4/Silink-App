import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';
import '../models/client_model.dart';

/// شيت اختيار حالة العميل — مطابق للتصميم: قائمة خيارات عمودية،
/// الخيار المحدد بحدود زرقاء وعلامة ✓ يسار، والباقي كروت بيضاء.
Future<void> showClientStatusSheet(
  BuildContext context, {
  required ClientStatus current,
  required ValueChanged<ClientStatus> onSelected,
}) {
  const options = [
    ClientStatus.newClient,
    ClientStatus.important,
    ClientStatus.contacted,
    ClientStatus.qualified,
    ClientStatus.lost,
    ClientStatus.notImportant,
  ];

  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => Container(
      padding: EdgeInsets.fromLTRB(19.w, 12.h, 19.w, 24.h),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              color: AppColors.borderColor.themeColor,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          AppText(
            LocaleKeys.clients_statusSheetTitle.tr(),
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
          16.height,
          ...options.map(
            (option) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: _StatusOption(
                label: option.statusLabel,
                selected: option == current,
                onTap: () {
                  Navigator.pop(context);
                  onSelected(option);
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _StatusOption extends StatelessWidget {
  const _StatusOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color:
              selected ? const Color(0xFFF5F8FF) : AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: selected
                ? const Color(0xFF2F6FED)
                : AppColors.borderColor.themeColor,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: AppText(
                label,
                fontSize: 14.sp,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected
                    ? const Color(0xFF2F6FED)
                    : AppColors.textPrimaryColor.themeColor,
                textAlign: TextAlign.center,
              ),
            ),
            if (selected)
              const Icon(Icons.check_rounded, color: Color(0xFF2F6FED)),
          ],
        ),
      ),
    );
  }
}
