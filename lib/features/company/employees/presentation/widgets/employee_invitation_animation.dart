import 'dart:math' as math;

import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/features/employee_invitation/presentation/widgets/invitation_rings_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeInvitationAnimation extends StatefulWidget {
  const EmployeeInvitationAnimation({super.key});

  @override
  State<EmployeeInvitationAnimation> createState() =>
      _EmployeeInvitationAnimationState();
}

class _EmployeeInvitationAnimationState
    extends State<EmployeeInvitationAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _badge() {
    return Container(
      width: 60.w,
      height: 60.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white.themeColor,
        border: Border.all(color: AppColors.accentGold.themeColor, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentGold.themeColor.withValues(alpha: 0.35),
            blurRadius: 22,
          ),
        ],
      ),
      child: Icon(
        Icons.send_rounded,
        size: 26.sp,
        color: AppColors.primaryColor.themeColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primaryColor.themeColor;
    return Container(
      height: 128.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            primary,
            Color.alphaBlend(
              AppColors.brandGreen.themeColor.withValues(alpha: 0.22),
              primary,
            ),
          ],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          PositionedDirectional(
            top: -50.h,
            end: -40.w,
            child: Container(
              width: 130.h,
              height: 130.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentGold.themeColor.withValues(alpha: 0.12),
              ),
            ),
          ),
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, __) => CustomPaint(
                painter: InvitationRingsPainter(
                  progress: _controller.value,
                  centerAlignmentY: 0,
                  scale: 0.62.w,
                  ringColor: AppColors.accentGold.themeColor,
                  dotColor: AppColors.white.themeColor,
                  accentColor: AppColors.accentGold.themeColor,
                ),
              ),
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, child) => Transform.translate(
                offset: Offset(
                  0,
                  math.sin(_controller.value * 2 * math.pi * 2) * 4.h,
                ),
                child: child,
              ),
              child: _badge(),
            ),
          ),
        ],
      ),
    );
  }
}
