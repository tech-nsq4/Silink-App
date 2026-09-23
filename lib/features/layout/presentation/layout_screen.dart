import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/features/clients/presentation/clients_screen.dart';
import 'package:Silink/features/my_card/presentation/my_cards_screen.dart';
import 'package:Silink/features/profile_completion/data/models/profile_completion_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../account/widgets/account_tab_body.dart';
import '../../home/presentation/home_screen.dart';
class LayoutScreen extends StatefulWidget {
  const LayoutScreen({
    super.key,
    this.currentPage = 0,
    this.cardData,
  });

  final int currentPage;
  final ProfileCompletionData? cardData;

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentPage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(),
            const MyCardsScreen(),
            const ClientsScreen(),
            const AccountTabBody(),
          ],
        ),
      ),
      bottomNavigationBar: _CustomNavBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({required this.labelKey, required this.icon});
  final String labelKey;
  final String icon;
}

final _navItems = [
  const _NavItem(labelKey: LocaleKeys.nav_home, icon: AppImages.iconsHome),
  const _NavItem(labelKey: LocaleKeys.nav_files, icon: AppImages.iconsPersonal),
  const _NavItem(
      labelKey: LocaleKeys.nav_clients, icon: AppImages.iconsClients),
  const _NavItem(
      labelKey: LocaleKeys.nav_account, icon: AppImages.iconsAccount),
];

// ── Custom nav bar ────────────────────────────────────────────────────────────

class _CustomNavBar extends StatelessWidget {
  const _CustomNavBar({required this.currentIndex, required this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.mint.themeColor;

    return Container(
      height: 75.h + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom, top: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: List.generate(_navItems.length, (i) {
          final item = _navItems[i];
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
                      isActive
                          ? primary
                          : AppColors.textSecondaryColor.themeColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  3.height,
                  AppText(
                    item.labelKey.tr(),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: isActive
                        ? primary
                        : AppColors.textSecondaryColor.themeColor,
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
                        color: AppColors.mint.themeColor,
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
