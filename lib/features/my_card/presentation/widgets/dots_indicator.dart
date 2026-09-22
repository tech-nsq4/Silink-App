import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class DotsIndicator extends StatelessWidget {
  final int count;
  final int current;

  const DotsIndicator({super.key, required this.count, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.symmetric(horizontal: 3.w),
          width: active ? 18.w : 6.w,
          height: 6.w,
          decoration: BoxDecoration(
            color: active
                ? AppColors.mint.themeColor
                : AppColors.borderColor.themeColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
        );
      }),
    );
  }
}
