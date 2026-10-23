import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/custom_loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeResendInviteTile extends StatelessWidget {
  const EmployeeResendInviteTile({
    super.key,
    required this.sending,
    required this.sent,
    required this.onTap,
    this.showDivider = true,
  });

  final bool sending;
  final bool sent;
  final VoidCallback onTap;
  final bool showDivider;

  Widget _leading(Color accent) {
    final Widget child = sending
        ? CustomLoadingWidget(
            key: const ValueKey('sending'),
            color: accent,
            size: 18,
          )
        : Icon(
            sent ? Icons.check_circle_rounded : Icons.forward_to_inbox_rounded,
            key: ValueKey(sent),
            size: 18.sp,
            color: accent,
          );
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 36.w,
      height: 36.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: sent
            ? accent.withValues(alpha: 0.14)
            : AppColors.studioSelectFill.themeColor,
        borderRadius: BorderRadius.circular(11.r),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, animation) =>
            ScaleTransition(scale: animation, child: child),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final successColor = AppColors.successColor.themeColor;
    final accent =
        sent ? successColor : AppColors.textSecondaryColor.themeColor;
    final titleColor =
        sent ? successColor : AppColors.textPrimaryColor.themeColor;
    final title = sending
        ? LocaleKeys.company_employee_invite_sending.tr()
        : sent
            ? LocaleKeys.company_employee_invite_resent.tr()
            : LocaleKeys.company_employee_resend_invite.tr();

    return InkWell(
      onTap: sending ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: sent ? successColor.withValues(alpha: 0.07) : null,
          border: showDivider
              ? Border(
                  bottom:
                      BorderSide(color: AppColors.studioStepLine.themeColor),
                )
              : null,
        ),
        child: Row(
          children: [
            _leading(accent),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w800,
                    color: titleColor,
                  ),
                  if (sent && !sending) ...[
                    2.height,
                    AppText(
                      LocaleKeys.company_employee_invite_view_link.tr(),
                      fontSize: 10.sp,
                      color: AppColors.textSecondaryColor.themeColor,
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.chevron_left_rounded,
              size: 18.sp,
              color: AppColors.studioRowIcon.themeColor,
            ),
          ],
        ),
      ),
    );
  }
}
