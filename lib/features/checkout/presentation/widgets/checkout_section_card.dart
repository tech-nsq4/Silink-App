import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_text.dart';

class CheckoutSectionCard extends StatelessWidget {
  const CheckoutSectionCard({
    super.key,
    required this.child,
    this.title,
    this.icon,
  });

  final Widget child;
  final String? title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null) ...[
            Row(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: 19.sp,
                    color: AppColors.successColor.themeColor,
                  ),
                  8.width,
                ],
                AppText(
                  title!,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                ),
              ],
            ),
            14.height,
          ],
          child,
        ],
      ),
    );
  }
}
