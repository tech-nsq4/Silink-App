import 'package:Silink/core/utils/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class CreateNewCardButton extends StatelessWidget {
  const CreateNewCardButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: _DashedContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 18.sp, color: AppColors.mint.themeColor),
            SizedBox(width: 8.w),
            AppText(
              LocaleKeys.myCards_createNewCard.tr(),
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.mint.themeColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _DashedContainer extends StatelessWidget {
  const _DashedContainer({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.mint.themeColor,
          width: 1.3,
        ),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: child,
    );
  }
}
