import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class StudioTemplateChoice extends StatelessWidget {
  const StudioTemplateChoice({
    super.key,
    required this.template,
    required this.label,
    required this.selected,
    required this.onTap,
    this.badge,
  });

  final String template;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    final isPro = template == 'pro';
    final isPersonal = template == 'personal';
    final artColor = switch (template) {
      'pro' => AppColors.studioCardEnd.themeColor,
      'personal' => AppColors.studioTemplateArtPersonal.themeColor,
      _ => AppColors.studioTemplateArt.themeColor,
    };
    final lineColor = isPro
        ? AppColors.studioTemplateArtProLine.themeColor
        : AppColors.studioTemplateArtLine.themeColor;
    final align =
        isPersonal ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    Widget line(double factor, double height, Color color) =>
        FractionallySizedBox(
          widthFactor: factor,
          child: Container(
            height: height,
            margin: EdgeInsets.symmetric(vertical: 2.5.h),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        );

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.all(9.w),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.studioTemplateSelected.themeColor
              : AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color:
                selected ? accent : AppColors.studioTemplateBorder.themeColor,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                Container(
                  width: 100.w,
                  height: 65.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: artColor,
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(
                        color: AppColors.studioFieldBorder.themeColor),
                  ),
                  child: Column(
                    crossAxisAlignment: align,
                    children: [
                      Container(
                        width: 18.w,
                        height: 18.w,
                        decoration: BoxDecoration(
                          color: AppColors.studioTemplateArtAvatar.themeColor,
                          shape:
                              isPersonal ? BoxShape.circle : BoxShape.rectangle,
                          borderRadius:
                              isPersonal ? null : BorderRadius.circular(5),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      line(0.8, 3, lineColor),
                      line(0.6, 2,
                          AppColors.studioTemplateArtLineSoft.themeColor),
                      line(0.6, 2,
                          AppColors.studioTemplateArtLineSoft.themeColor),
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
                AppText(
                  label,
                  fontSize: 10.sp,
                  color: selected
                      ? accent
                      : AppColors.studioTemplateText.themeColor,
                ),
                if (badge != null && badge!.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  AppText(
                    badge!,
                    fontSize: 8.sp,
                    color: AppColors.studioRowMeta.themeColor,
                  ),
                ],
              ],
            ),
            if (selected)
              PositionedDirectional(
                top: 6.h,
                end: 6.w,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration:
                      BoxDecoration(color: accent, shape: BoxShape.circle),
                  child: Icon(Icons.check_rounded,
                      size: 12.sp, color: AppColors.white.light),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
