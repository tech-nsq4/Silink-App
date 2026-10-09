import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class StudioDesignDetails extends StatefulWidget {
  const StudioDesignDetails({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  State<StudioDesignDetails> createState() => _StudioDesignDetailsState();
}

class _StudioDesignDetailsState extends State<StudioDesignDetails> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.studioDetailsTitle.themeColor;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 23.h),
      padding: EdgeInsets.all(17.w),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(13.r),
        border: Border.all(color: AppColors.assistantBackBorder.themeColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                AnimatedRotation(
                  turns: _expanded ? 0 : 0.25,
                  duration: const Duration(milliseconds: 180),
                  child: Icon(Icons.arrow_drop_down_rounded,
                      size: 20.sp, color: color),
                ),
                4.width,
                AppText(
                  widget.title,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ],
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.topCenter,
            child: _expanded
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final child in widget.children) ...[
                        SizedBox(height: 17.h),
                        child,
                      ],
                    ],
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}
