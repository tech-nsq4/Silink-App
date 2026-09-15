import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackgroundStyleCard extends StatelessWidget {
  const BackgroundStyleCard({
    super.key,
    required this.label,
    required this.preview,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final Widget preview;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: AppColors.white.themeColor,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: selected
                  ? AppColors.mint.themeColor
                  : AppColors.dividerColor.themeColor,
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: SizedBox(height: 40.h, width: double.infinity, child: preview),
              ),
              SizedBox(height: 8.h),
              AppText(label, fontSize: 12.sp, fontWeight: FontWeight.w600),
            ],
          ),
        ),
      ),
    );
  }
}
