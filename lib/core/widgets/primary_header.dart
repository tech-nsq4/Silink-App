import 'package:Silink/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PrimaryHeader extends StatelessWidget {
  const PrimaryHeader({
    super.key,
    required this.child,
    this.height,
    this.circleTopOffset = -65,
    this.circleEndOffset = -55,
    this.circleSize = 170,
  });

  final Widget child;

  /// Explicit height of the header.  Defaults to 37 % of screen height.
  final double? height;

  /// Vertical offset (in dp, will be converted to `.h`) of the decorative
  /// circle from the top edge.  Use a negative value to partially clip it.
  final double circleTopOffset;

  /// Horizontal offset (in dp, will be converted to `.w`) of the decorative
  /// circle from the trailing edge.
  final double circleEndOffset;

  /// Diameter of the decorative circle in dp (will be converted to `.h`).
  final double circleSize;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primaryColor.themeColor;
    final resolvedHeight = height ?? MediaQuery.sizeOf(context).height * 0.33;

    return SizedBox(
      height: resolvedHeight,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── Background ───────────────────────────────────────────────
          ColoredBox(color: primary),

          // ── Decorative semi-transparent gold circle ──────────────────
          PositionedDirectional(
            top: circleTopOffset.h,
            end: circleEndOffset.w,
            child: Container(
              width: circleSize.h,
              height: circleSize.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentGold.themeColor.withValues(alpha: 0.12),
              ),
            ),
          ),

          // ── Screen-specific content (inside SafeArea) ────────────────
          SafeArea(child: child),
        ],
      ),
    );
  }
}
