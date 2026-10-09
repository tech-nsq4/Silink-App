import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/app_text.dart';

class AssistantSourceField extends StatelessWidget {
  const AssistantSourceField({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    required this.example,
    required this.sampleLabel,
    required this.onUseSample,
    this.isLink = false,
    this.onChanged,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final String example;
  final String sampleLabel;
  final VoidCallback onUseSample;
  final bool isLink;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(isLink ? 12.r : 13.r),
      borderSide: BorderSide(color: AppColors.assistantSourceBorder.themeColor),
    );
    final focused = border.copyWith(
      borderSide: BorderSide(color: AppColors.accentTeal.themeColor),
    );
    final textStyle = TextStyle(
      fontFamily: AppFonts.familyFont,
      fontSize: 12.sp,
      height: isLink ? null : 1.9,
      color: AppColors.assistantSourceText.themeColor,
    );
    final hintStyle = textStyle.copyWith(
      color: AppColors.fieldHint.themeColor,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          label,
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.assistantSourceLabel.themeColor,
        ),
        SizedBox(height: 11.h),
        TextField(
          controller: controller,
          onChanged: onChanged,
          minLines: isLink ? 1 : 5,
          maxLines: isLink ? 1 : 8,
          keyboardType: isLink ? TextInputType.url : TextInputType.multiline,
          textDirection: isLink ? TextDirection.ltr : null,
          textAlign: isLink ? TextAlign.left : TextAlign.start,
          style: textStyle,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: hintStyle,
            hintTextDirection: isLink ? TextDirection.ltr : null,
            filled: true,
            fillColor: AppColors.white.themeColor,
            contentPadding: EdgeInsets.all(14.w),
            border: border,
            enabledBorder: border,
            focusedBorder: focused,
            suffixIcon: isLink
                ? Icon(
                    Icons.link_rounded,
                    size: 16.sp,
                    color: AppColors.assistantSourceIcon.themeColor,
                  )
                : null,
          ),
        ),
        SizedBox(height: 9.h),
        AppText(
          example,
          fontSize: 8.sp,
          height: 1.9,
          color: AppColors.assistantSourceHint.themeColor,
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: onUseSample,
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                sampleLabel,
                fontSize: 9.sp,
                color: AppColors.accentTeal.themeColor,
              ),
              5.width,
              Icon(
                Icons.arrow_forward_rounded,
                size: 12.sp,
                color: AppColors.accentTeal.themeColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
