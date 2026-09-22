import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RankingRowCard extends StatelessWidget {
  const RankingRowCard({
    super.key,
    required this.title,
    required this.icon,
    required this.enabled,
    required this.locked,
    this.hint,
    required this.canMoveUp,
    required this.canMoveDown,
    required this.onToggle,
    required this.onMoveUp,
    required this.onMoveDown,
  });

  final String title;
  final IconData icon;
  final bool enabled;
  final bool locked;
  final String? hint;
  final bool canMoveUp;
  final bool canMoveDown;
  final ValueChanged<bool> onToggle;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: locked ? const Color(0xFFF7F8FA) : AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.dividerColor.themeColor),
      ),
      child: Row(
        children: [
          if (locked)
            Icon(Icons.lock_outline,
                size: 16.sp, color: AppColors.textSecondaryColor.themeColor)
          else
            Container(
              padding: 8.paddingAll,
              decoration: BoxDecoration(
                color: AppColors.fieldFill,
                borderRadius: BorderRadius.circular(500.r),
              ),
              child: Icon(icon,
                  size: 15.sp, color: AppColors.textSecondaryColor.themeColor),
            ),
          8.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  title,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
                if (hint != null && hint!.isNotEmpty)
                  AppText(
                    hint!,
                    fontSize: 11.sp,
                    color: AppColors.textSecondaryColor.themeColor,
                  ),
              ],
            ),
          ),
          if (locked)
            Icon(Icons.person_outline,
                size: 18.sp, color: AppColors.textSecondaryColor.themeColor)
          else ...[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: canMoveUp ? onMoveUp : null,
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    size: 18.sp,
                    color: canMoveUp
                        ? AppColors.textSecondaryColor.themeColor
                        : AppColors.dividerColor.themeColor,
                  ),
                ),
                InkWell(
                  onTap: canMoveDown ? onMoveDown : null,
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 18.sp,
                    color: canMoveDown
                        ? AppColors.textSecondaryColor.themeColor
                        : AppColors.dividerColor.themeColor,
                  ),
                ),
              ],
            ),
            8.width,
            Switch(
              value: enabled,
              onChanged: onToggle,
              activeThumbColor: AppColors.mint.themeColor,
            ),
          ],
        ],
      ),
    );
  }
}
