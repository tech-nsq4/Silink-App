import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductRowCard extends StatelessWidget {
  const ProductRowCard({
    super.key,
    required this.name,
    required this.priceLabel,
    required this.price,
    this.imageUrl,
    required this.enabled,
    required this.canMoveUp,
    required this.canMoveDown,
    required this.isSaving,
    required this.onTap,
    required this.onToggle,
    required this.onMoveUp,
    required this.onMoveDown,
    required this.onEdit,
    required this.onDelete,
  });

  final String name;
  final String priceLabel;
  final String price;
  final String? imageUrl;
  final bool enabled;
  final bool canMoveUp;
  final bool canMoveDown;
  final bool isSaving;
  final VoidCallback onTap;
  final ValueChanged<bool> onToggle;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          margin: EdgeInsets.only(bottom: 10.h),
          decoration: BoxDecoration(
            color: AppColors.white.themeColor,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: AppColors.dividerColor.themeColor),
          ),
          child: Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.fieldFill,
                  borderRadius: BorderRadius.circular(10.r),
                  image: imageUrl != null && imageUrl!.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(imageUrl!), fit: BoxFit.cover)
                      : null,
                ),
                child: imageUrl == null || imageUrl!.isEmpty
                    ? Icon(Icons.inventory_2_outlined,
                        size: 18.sp,
                        color: AppColors.textSecondaryColor.themeColor)
                    : null,
              ),
              8.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      name,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                    2.height,
                    AppText(
                      priceLabel.isEmpty ? price : '$priceLabel $price',
                      fontSize: 12.sp,
                      color: AppColors.textSecondaryColor.themeColor,
                    ),
                  ],
                ),
              ),
              8.width,
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
              if (isSaving)
                SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: CustomLoadingWidget(
                    color: AppColors.primaryColor.themeColor,
                    size: 20,
                  ),
                )
              else ...[
                Switch(
                  value: enabled,
                  onChanged: onToggle,
                  activeThumbColor: AppColors.mint.themeColor,
                ),
                8.width,
                InkWell(
                  onTap: onEdit,
                  child: Icon(Icons.edit_outlined,
                      size: 18.sp,
                      color: AppColors.textSecondaryColor.themeColor),
                ),
                8.width,
                InkWell(
                  onTap: onDelete,
                  child: Icon(Icons.delete_outline,
                      size: 20.sp, color: AppColors.errorColor.themeColor),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
