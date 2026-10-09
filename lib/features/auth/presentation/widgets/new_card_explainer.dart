import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class NewCardExplainer extends StatelessWidget {
  const NewCardExplainer({
    super.key,
    required this.title,
    required this.body,
    this.steps = const [],
  });

  final String title;
  final String body;
  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 23.h, bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(title, fontSize: 14.sp, fontWeight: FontWeight.w800),
          SizedBox(height: 7.h),
          AppText(
            body,
            fontSize: 10.sp,
            height: 1.8,
            color: AppColors.explainerBody.themeColor,
          ),
          if (steps.isNotEmpty) SizedBox(height: 5.h),
          for (final (index, step) in steps.indexed)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Row(
                children: [
                  Container(
                    width: 23.w,
                    height: 23.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.stepBadge.themeColor,
                      shape: BoxShape.circle,
                    ),
                    child: AppText(
                      _localizedNumber(context, index + 1),
                      fontSize: 10.sp,
                      color: AppColors.accentTeal.themeColor,
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: AppText(
                      step,
                      fontSize: 11.sp,
                      color: AppColors.stepText.themeColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String _localizedNumber(BuildContext context, int value) {
    if (Localizations.localeOf(context).languageCode != 'ar') {
      return '$value';
    }
    const digits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return '$value'.split('').map((d) => digits[int.parse(d)]).join();
  }
}
