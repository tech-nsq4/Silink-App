import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class AuthModeTabs extends StatelessWidget {
  const AuthModeTabs({
    super.key,
    required this.isRegister,
    this.onLoginTap,
    this.onRegisterTap,
  });

  final bool isRegister;
  final VoidCallback? onLoginTap;
  final VoidCallback? onRegisterTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderColor.themeColor),
        ),
      ),
      child: Row(
        children: [
          _tab(LocaleKeys.auth_login.tr(), !isRegister, onLoginTap),
          _tab(LocaleKeys.auth_register.tr(), isRegister, onRegisterTap),
        ],
      ),
    );
  }

  Widget _tab(String label, bool active, VoidCallback? onTap) {
    final accent = AppColors.accentTeal.themeColor;
    return Expanded(
      child: GestureDetector(
        onTap: active ? null : onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: active ? accent : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: AppText(
            label,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: active ? accent : AppColors.tabInactive.themeColor,
          ),
        ),
      ),
    );
  }
}
