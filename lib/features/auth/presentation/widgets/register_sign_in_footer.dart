import 'package:easy_localization/easy_localization.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class RegisterSignInFooter extends StatelessWidget {
  const RegisterSignInFooter({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            LocaleKeys.auth_alreadyHaveAccount.tr(),
            fontSize: 14,
            color: AppColors.textSecondaryColor.themeColor,
            fontWeight: FontWeight.w500,
          ),
          4.width,
          GestureDetector(
            onTap: onTap,
            child: AppText(
              LocaleKeys.auth_signIn.tr(),
              fontSize: 14,
              color: AppColors.mint.themeColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
