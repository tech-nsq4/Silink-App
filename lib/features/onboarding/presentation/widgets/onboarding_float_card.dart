import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class OnboardingFloatCard extends StatelessWidget {
  const OnboardingFloatCard({
    super.key,
    required this.child,
    required this.padding,
    required this.radius,
  });

  final Widget child;
  final double padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: AppColors.white.light,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.floatShadow.themeColor.withValues(alpha: 0.086),
            blurRadius: 25,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}
