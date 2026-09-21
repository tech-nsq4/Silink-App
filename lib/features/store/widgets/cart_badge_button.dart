import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';

class CartBadgeButton extends StatelessWidget {
  const CartBadgeButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.h,
      width: 36.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.successColor.themeColor.withValues(alpha: 0.10),
        shape: BoxShape.circle,
      ),
      child: onTap == null
          ? const SizedBox.shrink()
          : IconButton(
              onPressed: onTap,
              icon: Icon(
                Icons.shopping_cart_outlined,
                size: 20.sp,
                color: AppColors.successColor.themeColor,
              ),
            ),
    );
  }
}
