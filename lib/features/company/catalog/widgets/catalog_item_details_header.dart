import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CatalogItemDetailsHeader extends StatelessWidget {
  const CatalogItemDetailsHeader({
    super.key,
    required this.title,
    required this.onBack,
    required this.onClose,
    this.action,
  });

  final String title;
  final VoidCallback onBack;
  final VoidCallback onClose;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      padding: EdgeInsetsDirectional.fromSTEB(16.w, 24.h, 16.w, 8.h),
      color: AppColors.cardColor.themeColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: AppText(
              title,
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          PositionedDirectional(
            start: 0,
            child: Semantics(
              button: true,
              label: LocaleKeys.company_back.tr(),
              child: InkWell(
                onTap: onBack,
                borderRadius: BorderRadius.circular(12.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        size: 16.sp,
                        color: AppColors.textPrimaryColor.themeColor,
                      ),
                      3.width,
                      AppText(
                        LocaleKeys.company_back.tr(),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          PositionedDirectional(
            end: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (action != null) ...[
                  action!,
                  6.width,
                ],
                Semantics(
                  button: true,
                  label: LocaleKeys.company_close.tr(),
                  child: InkWell(
                    onTap: onClose,
                    borderRadius: BorderRadius.circular(20.r),
                    child: Container(
                      height: 30.h,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        color: AppColors.dropdownSurface.themeColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.close_rounded,
                            size: 15.sp,
                            color: AppColors.overlayOnDark.themeColor,
                          ),
                          3.width,
                          AppText(
                            LocaleKeys.publish_exitPreview.tr(),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.overlayOnDark.themeColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
