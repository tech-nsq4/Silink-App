import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/app_text.dart';

class PlanSectionTitle extends StatelessWidget {
  const PlanSectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 4.w),
      child: AppText(
        title,
        fontSize: 15.sp,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
