import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvitationErrorView extends StatelessWidget {
  const InvitationErrorView({
    super.key,
    required this.message,
    required this.onRetry,
    required this.onBack,
  });

  final String message;
  final VoidCallback onRetry;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.link_off_rounded,
              size: 52.sp,
              color: AppColors.textSecondaryColor.themeColor,
            ),
            14.height,
            AppText(
              message,
              fontSize: 13.sp,
              textAlign: TextAlign.center,
              color: AppColors.textSecondaryColor.themeColor,
            ),
            20.height,
            CustomButton(
              onTap: onRetry,
              title: LocaleKeys.invitation_retry.tr(),
              expanded: false,
              widerPadding: true,
              height: 44,
            ),
            10.height,
            CustomButton(
              onTap: onBack,
              title: LocaleKeys.invitation_backToLogin.tr(),
              expanded: false,
              widerPadding: true,
              isOutlined: true,
              color: Colors.transparent,
              borderColor: AppColors.borderColor.themeColor,
              textColor: AppColors.textPrimaryColor.themeColor,
              height: 44,
            ),
          ],
        ),
      ),
    );
  }
}
