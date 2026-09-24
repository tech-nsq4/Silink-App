import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

/// Generic spinner + title/description shown while something is in progress
/// (currently used for the "validating serial" step).
class NfcStepStatus extends StatelessWidget {
  const NfcStepStatus({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 60.h),
      child: Column(
        children: [
          SizedBox(
            width: 80.w,
            height: 80.w,
            child: const CircularProgressIndicator(),
          ),
          20.height,
          AppText(title, fontSize: 16.sp, fontWeight: FontWeight.w700),
          6.height,
          AppText(
            description,
            fontSize: 13.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
        ],
      ),
    );
  }
}
