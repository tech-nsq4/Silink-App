import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class SplashLoadingIndicator extends StatefulWidget {
  const SplashLoadingIndicator({super.key, required this.label});

  final String label;

  @override
  State<SplashLoadingIndicator> createState() => _SplashLoadingIndicatorState();
}

class _SplashLoadingIndicatorState extends State<SplashLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 30,
          height: 3,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => Align(
              alignment: AlignmentDirectional.centerStart,
              child: FractionallySizedBox(
                widthFactor:
                    0.35 + 0.65 * Curves.easeInOut.transform(_controller.value),
                child: child,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: LinearGradient(
                  colors: [
                    AppColors.accentTeal.themeColor,
                    AppColors.accentBlue.themeColor,
                  ],
                ),
              ),
            ),
          ),
        ),
        10.width,
        AppText(
          widget.label,
          fontSize: 10.sp,
          color: AppColors.splashLoading.themeColor,
        ),
      ],
    );
  }
}
