import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class StudioSubtleNote extends StatelessWidget {
  const StudioSubtleNote({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.studioNote.themeColor;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Row(
        children: [
          Icon(Icons.visibility_outlined, size: 15.sp, color: color),
          7.width,
          Expanded(child: AppText(text, fontSize: 10.sp, color: color)),
        ],
      ),
    );
  }
}
