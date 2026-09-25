import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeInviteSuccessView extends StatelessWidget {
  const EmployeeInviteSuccessView({
    super.key,
    required this.name,
    required this.onViewList,
    required this.onInviteAnother,
  });

  final String name;
  final VoidCallback onViewList;
  final VoidCallback onInviteAnother;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFF0FDFA), Color(0xFFDCFCE7)],
                ),
              ),
              child: Icon(
                Icons.check_circle_outline_rounded,
                size: 42.sp,
                color: const Color(0xFF0D9488),
              ),
            ),
            20.height,
            AppText(
              LocaleKeys.company_invite_sent.tr(),
              fontSize: 19.sp,
              fontWeight: FontWeight.w700,
            ),
            8.height,
            AppText(
              LocaleKeys.company_invite_sent_desc.tr(
                namedArgs: {'name': name},
              ),
              fontSize: 13.sp,
              color: AppColors.textSecondaryColor.themeColor,
              textAlign: TextAlign.center,
              height: 1.5,
            ),
            28.height,
            CustomButton(
              onTap: onViewList,
              title: LocaleKeys.company_view_employees_list.tr(),
              height: 48,
              radius: 14,
              color: AppColors.blue.themeColor,
              fontSize: 15,
            ),
            12.height,
            CustomButton(
              onTap: onInviteAnother,
              title: LocaleKeys.company_invite_another.tr(),
              isOutlined: true,
              color: Colors.transparent,
              borderColor: AppColors.borderColor.themeColor,
              textColor: AppColors.textPrimaryColor.themeColor,
              height: 48,
              radius: 14,
              fontSize: 15,
            ),
          ],
        ),
      ),
    );
  }
}
