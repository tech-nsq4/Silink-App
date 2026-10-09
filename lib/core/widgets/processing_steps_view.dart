import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import 'app_text.dart';
import 'processing_step_row.dart';

class ProcessingStepsView extends StatefulWidget {
  const ProcessingStepsView({
    super.key,
    required this.title,
    required this.body,
    required this.steps,
    required this.completedSteps,
  });

  final String title;
  final String body;
  final List<String> steps;
  final int completedSteps;

  @override
  State<ProcessingStepsView> createState() => _ProcessingStepsViewState();
}

class _ProcessingStepsViewState extends State<ProcessingStepsView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _spin = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat();

  @override
  void dispose() {
    _spin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 45.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 65.w,
            height: 65.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.assistantLoading.themeColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: RotationTransition(
              turns: _spin,
              child: SizedBox(
                width: 26.w,
                height: 26.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  value: 0.75,
                  strokeCap: StrokeCap.round,
                  color: accent,
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          AppText(
            widget.title,
            fontSize: 26.sp,
            fontWeight: FontWeight.w800,
          ),
          SizedBox(height: 10.h),
          AppText(
            widget.body,
            fontSize: 11.sp,
            height: 1.9,
            color: AppColors.assistantLoadingBody.themeColor,
          ),
          SizedBox(height: 29.h),
          for (final (index, step) in widget.steps.indexed)
            ProcessingStepRow(
              label: step,
              number: index + 1,
              active: index <= widget.completedSteps,
              done: index < widget.completedSteps,
            ),
        ],
      ),
    );
  }
}
