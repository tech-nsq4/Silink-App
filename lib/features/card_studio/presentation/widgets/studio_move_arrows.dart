import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class StudioMoveArrows extends StatelessWidget {
  const StudioMoveArrows({
    super.key,
    required this.color,
    this.onUp,
    this.onDown,
    this.size,
  });

  final Color color;
  final VoidCallback? onUp;
  final VoidCallback? onDown;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _arrow(Icons.keyboard_arrow_up_rounded, onUp),
        _arrow(Icons.keyboard_arrow_down_rounded, onDown),
      ],
    );
  }

  Widget _arrow(IconData icon, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        child: Icon(
          icon,
          size: size ?? 20.sp,
          color: onTap == null ? AppColors.studioStepLine.themeColor : color,
        ),
      ),
    );
  }
}
