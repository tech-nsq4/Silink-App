import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class AuthGuestLink extends StatelessWidget {
  const AuthGuestLink({
    super.key,
    required this.label,
    required this.onTap,
    this.showArrow = true,
  });

  final String label;
  final bool showArrow;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.ghostAction.themeColor;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.all(14.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(label, fontSize: 10.sp, color: color),
            if (showArrow) ...[
              7.width,
              Icon(Icons.arrow_forward_rounded, size: 13.sp, color: color),
            ],
          ],
        ),
      ),
    );
  }
}
