import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/company/employees/data/models/employee_invitation_model.dart';
import 'package:Silink/features/company/employees/presentation/widgets/employee_invitation_animation.dart';
import 'package:Silink/features/company/employees/presentation/widgets/employee_invitation_expiry.dart';
import 'package:Silink/features/company/employees/presentation/widgets/employee_invitation_link_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

class EmployeeInvitationCard extends StatelessWidget {
  const EmployeeInvitationCard({super.key, required this.invitation});

  final EmployeeInvitationModel invitation;

  Future<void> _share(BuildContext context) {
    final box = context.findRenderObject() as RenderBox?;
    final origin =
        box == null ? null : box.localToGlobal(Offset.zero) & box.size;
    return Share.share(
      LocaleKeys.company_invite_share_message.tr(
        namedArgs: {'link': invitation.shareLink},
      ),
      sharePositionOrigin: origin,
    );
  }

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: invitation.shareLink));
    AppOverlay.showSuccess(LocaleKeys.company_invite_link_copied.tr());
  }

  String? _expiryText(BuildContext context) {
    final expiresAt = invitation.expiresAt?.toLocal();
    if (expiresAt == null) return null;
    final locale = context.locale.languageCode;
    return LocaleKeys.company_invite_expires_at.tr(
      namedArgs: {
        'date': DateFormat('EEEE d MMMM y', locale).format(expiresAt),
        'time': DateFormat('hh:mm a', locale).format(expiresAt),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final expiryText = _expiryText(context);
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.cardColor.themeColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.themeColor.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const EmployeeInvitationAnimation(),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  LocaleKeys.company_invite_link_label.tr(),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondaryColor.themeColor,
                ),
                8.height,
                EmployeeInvitationLinkBox(
                  link: invitation.shareLink,
                  onTap: _copy,
                ),
                if (expiryText != null) ...[
                  12.height,
                  EmployeeInvitationExpiry(text: expiryText),
                ],
                16.height,
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onTap: _copy,
                        title: LocaleKeys.company_invite_copy.tr(),
                        isOutlined: true,
                        color: Colors.transparent,
                        borderColor: AppColors.borderColor.themeColor,
                        textColor: AppColors.textPrimaryColor.themeColor,
                        height: 46,
                        radius: 14,
                        fontSize: 13,
                      ),
                    ),
                    10.width,
                    Expanded(
                      child: Builder(
                        builder: (shareContext) => CustomButton(
                          onTap: () => _share(shareContext),
                          title: LocaleKeys.company_invite_share.tr(),
                          height: 46,
                          radius: 14,
                          color: AppColors.primaryColor.themeColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
