import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/app_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<String?> showEditFieldSheet(
  BuildContext context, {
  required String title,
  required String hint,
  required String initialValue,
}) {
  final controller = TextEditingController(text: initialValue);
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(19.w, 20.h, 19.w, 20.h),
          decoration: BoxDecoration(
            color: AppColors.white.themeColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(title, fontSize: 16.sp, fontWeight: FontWeight.w700),
              SizedBox(height: 12.h),
              CustomTextField(
                hint: hint,
                controller: controller,
              ),
              SizedBox(height: 16.h),
              CustomButton(
                title: LocaleKeys.common_confirm.tr(),
                onTap: () =>
                    Navigator.pop(sheetContext, controller.text.trim()),
              ),
            ],
          ),
        ),
      );
    },
  );
}
