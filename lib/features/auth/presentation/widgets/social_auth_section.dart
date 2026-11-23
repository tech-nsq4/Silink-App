import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/services/social_auth_service.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/social_credential.dart';
import '../../logic/auth_cubit.dart';
import 'social_auth_button.dart';

class SocialAuthSection extends StatelessWidget {
  const SocialAuthSection({super.key, required this.loading});

  final bool loading;

  @override
  Widget build(BuildContext context) {
    final dividerColor = AppColors.softDivider.themeColor;
    final cubit = context.read<AuthCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: dividerColor)),
            12.width,
            AppText(
              LocaleKeys.auth_orContinueWith.tr(),
              fontSize: 9.sp,
              color: AppColors.subtleText.themeColor,
            ),
            12.width,
            Expanded(child: Divider(color: dividerColor)),
          ],
        ),
        16.height,
        SocialAuthButton(
          title: LocaleKeys.auth_continueWithGoogle.tr(),
          enabled: !loading,
          backgroundColor: AppColors.googleButtonBackground,
          borderColor: AppColors.googleButtonBorder,
          textColor: AppColors.googleButtonText,
          leading: SvgPicture.asset(AppImages.iconsGoogle, width: 20.w),
          onTap: () => cubit.socialLogin(SocialProvider.google),
        ),
        if (SocialAuthService.isAppleAvailable) ...[
          12.height,
          SocialAuthButton(
            title: LocaleKeys.auth_continueWithApple.tr(),
            enabled: !loading,
            backgroundColor: AppColors.appleButtonBackground,
            textColor: AppColors.appleButtonText,
            leading: Icon(
              Icons.apple,
              size: 22.sp,
              color: AppColors.appleButtonText,
            ),
            onTap: () => cubit.socialLogin(SocialProvider.apple),
          ),
        ],
        8.height,
      ],
    );
  }
}
