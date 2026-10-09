import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class StudioSavingBadge extends StatelessWidget {
  const StudioSavingBadge({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.studioSaving.themeColor;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check_rounded, size: 12.sp, color: color),
        4.width,
        AppText(label, fontSize: 9.sp, color: color),
      ],
    );
  }
}
