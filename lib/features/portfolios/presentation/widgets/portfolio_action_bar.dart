import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class PortfolioAction {
  const PortfolioAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
}

class PortfolioActionBar extends StatelessWidget {
  const PortfolioActionBar({
    super.key,
    required this.actions,
    this.vertical = false,
  });

  final List<PortfolioAction> actions;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    final secondary = AppColors.textSecondaryColor.themeColor;
    return IntrinsicHeight(
      child: Row(
        children: [
          for (final (index, action) in actions.indexed) ...[
            if (index > 0)
              VerticalDivider(
                width: 1,
                indent: 10.h,
                endIndent: 10.h,
                color: AppColors.studioStepLine.themeColor,
              ),
            Expanded(
              child: InkWell(
                onTap: action.onTap,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: vertical
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(action.icon, size: 17.sp, color: secondary),
                            SizedBox(height: 6.h),
                            AppText(action.label,
                                fontSize: 8.5.sp,
                                fontWeight: FontWeight.w700,
                                color: secondary),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(action.icon, size: 14.sp, color: secondary),
                            5.width,
                            AppText(action.label,
                                fontSize: 8.5.sp,
                                fontWeight: FontWeight.w700,
                                color: secondary),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
