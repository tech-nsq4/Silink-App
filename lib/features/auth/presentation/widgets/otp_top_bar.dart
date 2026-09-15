import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpTopBar extends StatelessWidget {
  const OtpTopBar({super.key, required this.title, this.onBack});

  final String title;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: AppText(
                title,
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          PositionedDirectional(
            end: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: InkWell(
                onTap: onBack ?? () => Navigator.of(context).maybePop(),
                borderRadius: BorderRadius.circular(20.r),
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Icon(
                    Icons.chevron_left,
                    size: 22.sp,
                    color: AppColors.textPrimaryColor.themeColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
