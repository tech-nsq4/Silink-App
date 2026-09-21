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
    required this.canMoveUp,
    required this.canMoveDown,
    required this.onToggle,
    required this.onMoveUp,
    required this.onMoveDown,
  });

  final String title;
  final IconData icon;
  final bool enabled;
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
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.dividerColor.themeColor),
      ),
      child: Row(
        children: [
          Icon(Icons.drag_indicator,size: 28,),
          5.width,
          Container(
            padding: 8.paddingAll,
              decoration: BoxDecoration(

                color: AppColors.fieldFill,
                borderRadius: BorderRadius.circular(500.r),
              ),
              child: Icon(icon, size: 15.sp, color: AppColors.textSecondaryColor.themeColor)),
          SizedBox(width: 8.w),

          Expanded(
            child: AppText(
              title,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),

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
          SizedBox(width: 8.w),

          Switch(
            value: enabled,
            onChanged: onToggle,
            activeThumbColor: AppColors.mint.themeColor,
          ),
        ],
      ),
    );
  }
}
