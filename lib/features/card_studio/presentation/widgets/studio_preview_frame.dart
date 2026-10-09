import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/convert_helper.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class StudioPreviewFrame extends StatelessWidget {
  const StudioPreviewFrame({
    super.key,
    required this.child,
    this.background,
  });

  static final RegExp _hexPattern = RegExp(r'#[0-9a-fA-F]{6}');

  final Widget child;
  final String? background;

  BoxDecoration _decoration() {
    final colors = _hexPattern
        .allMatches(background ?? '')
        .map((m) => ConvertHelper.hexToColor(m.group(0)!))
        .toList();
    final radius = BorderRadius.circular(17.r);
    final border = Border.all(color: AppColors.studioOrderBorder.themeColor);
    if (colors.length >= 2) {
      return BoxDecoration(
        borderRadius: radius,
        border: border,
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      );
    }
    return BoxDecoration(
      borderRadius: radius,
      border: border,
      color: colors.isEmpty
          ? AppColors.studioLivePreview.themeColor
          : colors.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: EdgeInsets.all(18.w),
      decoration: _decoration(),
      child: Column(
        children: [
          child,
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 4.w,
                height: 4.w,
                decoration: BoxDecoration(
                  color: AppColors.studioLiveDot.themeColor,
                  shape: BoxShape.circle,
                ),
              ),
              5.width,
              AppText(
                LocaleKeys.cardStudio_livePreview.tr(),
                fontSize: 8.sp,
                color: AppColors.studioLivePreviewText.themeColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
