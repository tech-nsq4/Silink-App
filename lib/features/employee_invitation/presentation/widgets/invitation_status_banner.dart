import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/employee_invitation/data/models/invitation_details_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvitationStatusBanner extends StatelessWidget {
  const InvitationStatusBanner({super.key, required this.details});

  final InvitationDetailsModel details;

  String _expiryText(BuildContext context, DateTime expiresAt) {
    final local = expiresAt.toLocal();
    final locale = context.locale.languageCode;
    return LocaleKeys.company_invite_expires_at.tr(
      namedArgs: {
        'date': DateFormat('EEEE d MMMM y', locale).format(local),
        'time': DateFormat('hh:mm a', locale).format(local),
      },
    );
  }

  String _statusText() => switch (details.status) {
        'accepted' => LocaleKeys.invitation_statusAccepted.tr(),
        'expired' => LocaleKeys.invitation_statusExpired.tr(),
        _ => LocaleKeys.invitation_statusUnavailable.tr(),
      };

  @override
  Widget build(BuildContext context) {
    final expiresAt = details.expiresAt;
    final pending = details.isPending;
    if (pending && expiresAt == null) return const SizedBox.shrink();

    final color = pending
        ? AppColors.infoCardText.themeColor
        : AppColors.errorColor.themeColor;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: pending
            ? AppColors.infoCardBackground.themeColor
            : AppColors.errorColor.themeColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: pending
              ? AppColors.infoCardBorder.themeColor
              : AppColors.errorColor.themeColor.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            pending ? Icons.schedule_rounded : Icons.error_outline_rounded,
            size: 20.sp,
            color: pending ? AppColors.infoCardIcon.themeColor : color,
          ),
          10.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  pending ? _expiryText(context, expiresAt!) : _statusText(),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
                if (!pending) ...[
                  4.height,
                  AppText(
                    LocaleKeys.invitation_askNewLink.tr(),
                    fontSize: 11.sp,
                    color: AppColors.textSecondaryColor.themeColor,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
