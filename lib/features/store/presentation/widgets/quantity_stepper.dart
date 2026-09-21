import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onChanged,
    this.min = 1,
    this.max = 99,
  });

  final int quantity;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        QuantityStepButton(
          icon: Icons.remove,
          onTap: quantity > min ? () => onChanged(quantity - 1) : null,
        ),
        16.width,
        AppText(
          '$quantity',
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        16.width,
        QuantityStepButton(
          icon: Icons.add,
          onTap: quantity < max ? () => onChanged(quantity + 1) : null,
        ),
      ],
    );
  }
}

class QuantityStepButton extends StatelessWidget {
  const QuantityStepButton({super.key, required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 34.w,
        height: 34.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.borderColor.themeColor),
        ),
        child: Icon(
          icon,
          size: 16.sp,
          color: isEnabled
              ? AppColors.textPrimaryColor.themeColor
              : AppColors.borderColor.themeColor,
        ),
      ),
    );
  }
}
