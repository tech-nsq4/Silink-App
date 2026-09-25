import 'package:Silink/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCardDots extends StatelessWidget {
  const ProfileCardDots({
    super.key,
    required this.count,
    required this.current,
    required this.activeColor,
  });

  final int count;
  final int current;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: EdgeInsets.symmetric(horizontal: 3.w),
            width: i == current ? 18.w : 6.w,
            height: 6.w,
            decoration: BoxDecoration(
              color:
                  i == current ? activeColor : AppColors.borderColor.themeColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
      ],
    );
  }
}
