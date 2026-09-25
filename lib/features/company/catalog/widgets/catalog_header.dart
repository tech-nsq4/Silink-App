import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CatalogHeader extends StatelessWidget {
  const CatalogHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.titleIcon,
    this.onBack,
  });

  final String title;
  final String subtitle;
  final IconData titleIcon;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(19.w, 24.h, 19.w, 12.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderColor.themeColor),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    titleIcon,
                    size: 17.sp,
                    color: AppColors.companyBrand.themeColor,
                  ),
                  6.width,
                  Flexible(
                    child: AppText(
                      title,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              3.height,
              AppText(
                subtitle,
                fontSize: 12.sp,
                color: AppColors.textSecondaryColor.themeColor,
              ),
            ],
          ),
          PositionedDirectional(
            start: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: InkWell(
                onTap: onBack ?? () => Navigator.of(context).maybePop(),
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceColor.themeColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.borderColor.themeColor),
                  ),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 19.sp,
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
