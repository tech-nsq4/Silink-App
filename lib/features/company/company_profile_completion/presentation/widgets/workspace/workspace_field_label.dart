import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/app_text.dart';

class WorkspaceFieldLabel extends StatelessWidget {
  const WorkspaceFieldLabel({
    super.key,
    required this.text,
    this.required = false,
  });

  final String text;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: AppText(
        required ? '$text *' : text,
        fontSize: 11.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
