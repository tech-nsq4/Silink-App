import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class AuthFieldLabel extends StatelessWidget {
  const AuthFieldLabel({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: AppText(
        text,
        fontSize: 10.sp,
        color: AppColors.fieldLabel.themeColor,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
