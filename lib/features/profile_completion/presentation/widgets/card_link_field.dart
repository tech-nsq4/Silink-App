import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/app_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardLinkField extends StatelessWidget {
  CardLinkField({super.key});

  final TextEditingController _linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            LocaleKeys.publish_linkYourCard.tr(),
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
          8.height,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.fieldFill,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  '/silink.sa',
                  fontSize: 12.sp,
                ),
                8.width,
                Expanded(
                  child: CustomTextField(
                    hint: LocaleKeys.publish_enterHandle.tr(),
                    controller: _linkController,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
