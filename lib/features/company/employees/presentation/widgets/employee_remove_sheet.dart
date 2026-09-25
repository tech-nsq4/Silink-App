import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeRemoveSheet extends StatelessWidget {
  const EmployeeRemoveSheet({super.key});

  static Future<bool> show(BuildContext context) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: AppColors.cardColor.themeColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => const EmployeeRemoveSheet(),
    );
    return result == true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            LocaleKeys.company_employee_remove_confirm_title.tr(),
            fontSize: 17.sp,
            fontWeight: FontWeight.w800,
          ),
          8.height,
          AppText(
            LocaleKeys.company_employee_remove_confirm_desc.tr(),
            fontSize: 13.sp,
            color: AppColors.textSecondaryColor.themeColor,
            textAlign: TextAlign.center,
          ),
          20.height,
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onTap: () => Navigator.of(context).pop(false),
                  title: LocaleKeys.common_cancel.tr(),
                  isOutlined: true,
                  color: Colors.transparent,
                  borderColor: AppColors.borderColor.themeColor,
                  textColor: AppColors.textPrimaryColor.themeColor,
                  height: 44,
                  radius: 12,
                ),
              ),
              10.width,
              Expanded(
                child: CustomButton(
                  onTap: () => Navigator.of(context).pop(true),
                  title: LocaleKeys.common_delete.tr(),
                  color: AppColors.errorColor.themeColor,
                  borderColor: AppColors.errorColor.themeColor,
                  height: 44,
                  radius: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
