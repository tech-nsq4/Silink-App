import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class LayoutNavItem {
  const LayoutNavItem({required this.labelKey, required this.icon});

  final String labelKey;
  final String icon;
}

class LayoutNavBar extends StatelessWidget {
  const LayoutNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<LayoutNavItem> items = [
    LayoutNavItem(labelKey: LocaleKeys.nav_home, icon: AppImages.iconsHome),
    LayoutNavItem(
        labelKey: LocaleKeys.nav_files, icon: AppImages.iconsPersonal),
    LayoutNavItem(
        labelKey: LocaleKeys.nav_clients, icon: AppImages.iconsClients),
    LayoutNavItem(
        labelKey: LocaleKeys.nav_account, icon: AppImages.iconsAccount),
  ];

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.mint.themeColor;
    final inactive = AppColors.textSecondaryColor.themeColor;
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Container(
      height: 75.h + bottomInset,
      padding: EdgeInsets.only(bottom: bottomInset, top: 5),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: List.generate(items.length, (i) {
          final item = items[i];
          final isActive = i == currentIndex;

          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(i),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    item.icon,
                    width: 22.w,
                    height: 22.w,
                    colorFilter: ColorFilter.mode(
                      isActive ? primary : inactive,
                      BlendMode.srcIn,
                    ),
                  ),
                  3.height,
                  AppText(
                    item.labelKey.tr(),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: isActive ? primary : inactive,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  3.height,
                  if (isActive)
                    Container(
                      height: 5.w,
                      width: 5.w,
                      decoration: BoxDecoration(
                        color: primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
