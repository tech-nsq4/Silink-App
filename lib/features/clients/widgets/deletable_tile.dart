import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// بطاقة عنصر محفوظ (متابعة/ملاحظة) مع زر حذف.
class DeletableTile extends StatelessWidget {
  const DeletableTile({
    super.key,
    required this.title,
    required this.onDelete,
    this.titleWeight = FontWeight.w700,
    this.subtitle,
    this.subtitleColor,
  });

  final String title;
  final FontWeight titleWeight;
  final String? subtitle;
  final Color? subtitleColor;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  title,
                  fontSize: 12.sp,
                  fontWeight: titleWeight,
                ),
                if (subtitle != null && subtitle!.isNotEmpty) ...[
                  4.height,
                  AppText(
                    subtitle!,
                    fontSize: 11.sp,
                    height: 1.5,
                    color: subtitleColor ??
                        AppColors.textSecondaryColor.themeColor,
                  ),
                ],
              ],
            ),
          ),
          8.width,
          GestureDetector(
            onTap: onDelete,
            behavior: HitTestBehavior.opaque,
            child: Icon(
              Icons.delete_outline_rounded,
              size: 18.sp,
              color: AppColors.saleRed.themeColor,
            ),
          ),
        ],
      ),
    );
  }
}
