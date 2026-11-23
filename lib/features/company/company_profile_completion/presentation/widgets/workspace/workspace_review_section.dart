import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/extensions/extensions.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/locale_keys.dart';
import '../../../../../../core/widgets/app_text.dart';

class WorkspaceReviewSection extends StatelessWidget {
  const WorkspaceReviewSection({
    super.key,
    required this.title,
    required this.onEdit,
    required this.child,
  });

  final String title;
  final VoidCallback onEdit;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    return Container(
      margin: EdgeInsets.only(top: 14.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.studioPanelBorder.themeColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: AppText(
                  title,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              GestureDetector(
                onTap: onEdit,
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    Icon(Icons.edit_outlined, size: 13.sp, color: accent),
                    4.width,
                    AppText(
                      LocaleKeys.companyWorkspace_reviewEdit.tr(),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: accent,
                    ),
                  ],
                ),
              ),
            ],
          ),
          14.height,
          child,
        ],
      ),
    );
  }
}
