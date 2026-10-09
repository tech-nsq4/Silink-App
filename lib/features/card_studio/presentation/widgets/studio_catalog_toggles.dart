import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import 'studio_toggle.dart';

class StudioCatalogToggles extends StatelessWidget {
  const StudioCatalogToggles({
    super.key,
    required this.servicesEnabled,
    required this.productsEnabled,
    required this.onServicesChanged,
    required this.onProductsChanged,
  });

  final bool servicesEnabled;
  final bool productsEnabled;
  final ValueChanged<bool> onServicesChanged;
  final ValueChanged<bool> onProductsChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 18.h),
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColors.studioPanelBorder.themeColor),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _option(
                icon: Icons.work_outline_rounded,
                title: LocaleKeys.cardStudio_servicesToggle.tr(),
                hint: LocaleKeys.cardStudio_servicesToggleHint.tr(),
                enabled: servicesEnabled,
                onChanged: onServicesChanged,
              ),
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: _option(
                icon: Icons.inventory_2_outlined,
                title: LocaleKeys.cardStudio_productsToggle.tr(),
                hint: LocaleKeys.cardStudio_productsToggleHint.tr(),
                enabled: productsEnabled,
                onChanged: onProductsChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _option({
    required IconData icon,
    required String title,
    required String hint,
    required bool enabled,
    required ValueChanged<bool> onChanged,
  }) {
    final accent = AppColors.accentTeal.themeColor;
    return GestureDetector(
      onTap: () => onChanged(!enabled),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: enabled
              ? AppColors.methodSelected.themeColor
              : AppColors.studioFieldFill.themeColor,
          borderRadius: BorderRadius.circular(11.r),
          border: Border.all(
            color: enabled
                ? accent.withValues(alpha: 0.35)
                : AppColors.studioStepLine.themeColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 32.w,
                  height: 32.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: enabled
                        ? AppColors.white.themeColor
                        : AppColors.studioItemIcon.themeColor,
                    borderRadius: BorderRadius.circular(9.r),
                  ),
                  child: Icon(
                    icon,
                    size: 17.sp,
                    color: enabled
                        ? accent
                        : AppColors.studioItemIconColor.themeColor,
                  ),
                ),
                StudioToggle(value: enabled, onChanged: onChanged),
              ],
            ),
            SizedBox(height: 10.h),
            AppText(title, fontSize: 12.sp, fontWeight: FontWeight.w700),
            SizedBox(height: 4.h),
            AppText(
              hint,
              fontSize: 9.sp,
              height: 1.6,
              color: AppColors.studioRowMeta.themeColor,
            ),
          ],
        ),
      ),
    );
  }
}
