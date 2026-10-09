import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class HomeCardAction {
  const HomeCardAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
}

class HomeCardActions extends StatelessWidget {
  const HomeCardActions({super.key, required this.actions});

  final List<HomeCardAction> actions;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.studioPanelBorder.themeColor),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            for (final (index, action) in actions.indexed) ...[
              if (index > 0)
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  indent: 6.h,
                  endIndent: 6.h,
                  color: AppColors.studioStepLine.themeColor,
                ),
              Expanded(
                child: InkWell(
                  onTap: action.onTap,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(action.icon, size: 19.sp, color: accent),
                      SizedBox(height: 8.h),
                      AppText(
                        action.label,
                        fontSize: 8.5.sp,
                        fontWeight: FontWeight.w700,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
