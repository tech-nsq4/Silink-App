import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/extensions.dart';
import '../utils/app_colors.dart';
import 'app_text.dart';

class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onChanged,
    this.min = 1,
    this.max = 99,
    this.compact = false,
  });

  final int quantity;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final spacing = compact ? 12 : 20;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        QuantityStepButton(
          icon: Icons.remove,
          size: compact ? 28 : 36,
          onTap: quantity > min ? () => onChanged(quantity - 1) : null,
        ),
        spacing.width,
        AppText(
          '$quantity',
          fontSize: (compact ? 14 : 16).sp,
          fontWeight: FontWeight.w700,
        ),
        spacing.width,
        QuantityStepButton(
          icon: Icons.add,
          size: compact ? 28 : 36,
          onTap: quantity < max ? () => onChanged(quantity + 1) : null,
        ),
      ],
    );
  }
}

class QuantityStepButton extends StatelessWidget {
  const QuantityStepButton({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 36,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: size.w,
        height: size.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.cardColor.themeColor,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.borderColor.themeColor),
        ),
        child: Icon(
          icon,
          size: (size * 0.45).sp,
          color: isEnabled
              ? AppColors.textPrimaryColor.themeColor
              : AppColors.borderColor.themeColor,
        ),
      ),
    );
  }
}
