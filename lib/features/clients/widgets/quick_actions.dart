import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';


class QuickActions extends StatelessWidget {
  const QuickActions({
    super.key,
    required this.hasEmail,
    required this.onCall,
    required this.onWhatsapp,
    required this.onEmail,
    required this.onSaveContact,
  });

  final bool hasEmail;
  final VoidCallback onCall;
  final VoidCallback onWhatsapp;
  final VoidCallback onEmail;
  final VoidCallback onSaveContact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: ActionButton(
                label: LocaleKeys.clients_call.tr(),
                icon: AppImages.iconsCall,
                foreground: AppColors.mint.themeColor,
                background: const Color(0xFFf0fdf4),
                borderColor: Color(0xFFbbf7d0),
                onTap: onCall,
              ),
            ),
            12.width,
            Expanded(
              child: ActionButton(
                label: LocaleKeys.clients_whatsapp.tr(),
                icon: AppImages.iconsChat,
                foreground: AppColors.mint.themeColor,
                background: const Color(0xFFf0fdf4),
                borderColor: Color(0xFFbbf7d0),
                onTap: onWhatsapp,
              ),
            ),
          ],
        ),
        12.height,
        Row(
          children: [
            Expanded(
              child: ActionButton(
                label: LocaleKeys.clients_sendEmail.tr(),
                icon: AppImages.iconsGmail,
                foreground: const Color(0xFF2F6FED),
                background: const Color(0xFFE8F0FE),
                borderColor: Color(0xFFa7d3f8),
                onTap: hasEmail ? onEmail : null,
              ),
            ),
            12.width,
            Expanded(
              child: ActionButton(
                label: LocaleKeys.clients_saveContact.tr(),
                icon: AppImages.iconsSave,
                foreground: const Color(0xFF7C3AED),
                background: const Color(0xFFF3E8FF),
                borderColor: Color(0xFFd9c2e6),
                onTap: onSaveContact,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// زر إجراء بعنوان وأيقونة — لون أمامي وخلفية مخصصان.
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.background,
    required this.onTap,
    this.foreground,
    required this.borderColor,
  });

  final String label;
  final String icon;
  final Color background;
  final Color? foreground;
  final VoidCallback? onTap;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final color = foreground ?? Colors.white;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: borderColor,
            width: 1.r,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(icon,
                height: 18.sp,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn)),
            4.height,
            Flexible(
              child: AppText(
                label,
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
