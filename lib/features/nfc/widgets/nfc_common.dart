import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class NfcPrimaryButton extends StatelessWidget {
  const NfcPrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blue.themeColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class NfcSecondaryButton extends StatelessWidget {
  const NfcSecondaryButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimaryColor.themeColor,
          side: BorderSide(color: AppColors.borderColor.themeColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

/// One checkmark + label row used in the intro requirements list.
class NfcRequirementRow extends StatelessWidget {
  const NfcRequirementRow({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 22.w,
          height: 22.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.blue.themeColor.withValues(alpha: 0.1),
            border: Border.all(color: AppColors.blue.themeColor, width: 1.5),
          ),
          child: Icon(
            Icons.check_rounded,
            size: 12.sp,
            color: AppColors.blue.themeColor,
          ),
        ),
        8.width,
        Expanded(
          child: AppText(text, fontSize: 13.sp),
        ),
      ],
    );
  }
}

/// A label/value row used in the confirm & done summary cards.
class NfcKeyValueRow extends StatelessWidget {
  const NfcKeyValueRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderColor.themeColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            label,
            fontSize: 13.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
          Flexible(
            child: AppText(
              value,
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: valueColor,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
