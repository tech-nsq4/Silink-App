import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialAuthButtons extends StatelessWidget {
  final VoidCallback? onGoogleTap;
  final VoidCallback? onAppleTap;

  const SocialAuthButtons({
    super.key,
    this.onGoogleTap,
    this.onAppleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SocialButton(
          title: 'متابعة مع Apple',
          iconPath: AppImages.iconsApple,
          onTap: onAppleTap,
        ),
        12.height,
        _SocialButton(
          title: 'متابعة مع Google',
          iconPath: AppImages.iconsGoogle,
          onTap: onGoogleTap,
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback? onTap;

  const _SocialButton({
    required this.title,
    required this.iconPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: double.infinity,
        height: 54.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath),
            12.width,
            AppText(
              title,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black.themeColor,
            ),
          ],
        ),
      ),
    );
  }
}
