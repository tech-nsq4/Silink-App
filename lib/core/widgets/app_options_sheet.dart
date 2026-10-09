import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import 'app_text.dart';
import 'custom_tap_effect.dart';

class AppOptionsSheet<T> extends StatelessWidget {
  const AppOptionsSheet({
    super.key,
    required this.title,
    required this.value,
    required this.options,
    required this.labelOf,
  });

  final String title;
  final T value;
  final List<T> options;
  final String Function(T option) labelOf;

  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required T value,
    required List<T> options,
    required String Function(T option) labelOf,
  }) =>
      showModalBottomSheet<T>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: AppColors.profileHero.themeColor.withValues(alpha: 0.53),
        builder: (_) => AppOptionsSheet<T>(
          title: title,
          value: value,
          options: options,
          labelOf: labelOf,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    return Container(
      constraints: BoxConstraints(maxHeight: 0.7.sh),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.studioStepLine.themeColor,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 10.h),
              child: AppText(
                title,
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 16.h),
                itemCount: options.length,
                separatorBuilder: (_, __) => SizedBox(height: 8.h),
                itemBuilder: (context, index) {
                  final option = options[index];
                  final selected = option == value;
                  return CustomTapEffect(
                    onTap: () => Navigator.of(context).pop(option),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: EdgeInsets.symmetric(
                          horizontal: 14.w, vertical: 13.h),
                      decoration: BoxDecoration(
                        color: selected
                            ? accent.withValues(alpha: 0.07)
                            : AppColors.studioSelectFill.themeColor,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: selected
                              ? accent
                              : AppColors.assistantBackBorder.themeColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppText(
                              labelOf(option),
                              fontSize: 12.sp,
                              fontWeight:
                                  selected ? FontWeight.w700 : FontWeight.w500,
                              color: selected ? accent : null,
                            ),
                          ),
                          Icon(
                            selected
                                ? Icons.check_circle_rounded
                                : Icons.circle_outlined,
                            size: 18.sp,
                            color: selected
                                ? accent
                                : AppColors.studioStepLine.themeColor,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
