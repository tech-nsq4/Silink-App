import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductRowCard extends StatelessWidget {
  const ProductRowCard({
    super.key,
    required this.name,
    required this.price,
    required this.enabled,
    required this.canMoveUp,
    required this.canMoveDown,
    required this.onToggle,
    required this.onMoveUp,
    required this.onMoveDown,
    required this.onEdit,
    required this.onDelete,
  });

  final String name;
  final String price;
  final bool enabled;
  final bool canMoveUp;
  final bool canMoveDown;
  final ValueChanged<bool> onToggle;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

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
          InkWell(
            onTap: onDelete,
            child: Icon(Icons.delete_outline,
                size: 20.sp, color: AppColors.errorColor.themeColor),
          ),
          8.width,
          InkWell(
            onTap: onEdit,
            child: Icon(Icons.edit_outlined,
                size: 18.sp, color: AppColors.textSecondaryColor.themeColor),
          ),
          8.width,
          Switch(
            value: enabled,
            onChanged: onToggle,
            activeThumbColor: AppColors.mint.themeColor,
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
          8.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AppText(
                  name,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                ),
                2.height,
                AppText(
                  price,
                  fontSize: 12.sp,
                  color: AppColors.textSecondaryColor.themeColor,
                ),
              ],
            ),
          ),
          8.width,
          Container(
            width: 44.w,
            height: 44.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.fieldFill,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(Icons.inventory_2_outlined,
                size: 18.sp, color: AppColors.textSecondaryColor.themeColor),
          ),
        ],
      ),
    );
  }
}
