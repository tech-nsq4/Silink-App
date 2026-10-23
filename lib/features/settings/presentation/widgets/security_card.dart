import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class SecurityCard extends StatelessWidget {
  const SecurityCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.studioPanelBorder.themeColor),
      ),
      child: Column(
        children: [
          for (final (index, child) in children.indexed) ...[
            if (index > 0)
              Divider(height: 1, color: AppColors.studioStepLine.themeColor),
            child,
          ],
        ],
      ),
    );
  }
}
