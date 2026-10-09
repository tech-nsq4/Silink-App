import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/widgets/app_text.dart';

class ShopQuantityBox extends StatelessWidget {
  const ShopQuantityBox({
    super.key,
    required this.quantity,
    required this.onChanged,
  });

  final int quantity;
  final ValueChanged<int> onChanged;

  Widget _button(IconData icon, VoidCallback? onTap) => InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          child: Icon(
            icon,
            size: 16.sp,
            color: onTap == null
                ? AppColors.studioStepLine.themeColor
                : AppColors.textSecondaryColor.themeColor,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.studioPanelBorder.themeColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _button(
            Icons.remove_rounded,
            quantity > 1 ? () => onChanged(quantity - 1) : null,
          ),
          SizedBox(
            width: 22.w,
            child: AppText(
              '$quantity',
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),
          ),
          _button(
            Icons.add_rounded,
            quantity < AppConstants.maxCartItemQuantity
                ? () => onChanged(quantity + 1)
                : null,
          ),
        ],
      ),
    );
  }
}
