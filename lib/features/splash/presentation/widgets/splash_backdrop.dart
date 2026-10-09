import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class SplashBackdrop extends StatelessWidget {
  const SplashBackdrop({super.key});

  static const double _orbitSize = 380;

  @override
  Widget build(BuildContext context) {
    final white = AppColors.white.light;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: _GridPainter(color: white.withValues(alpha: 0.016)),
          ),
        ),
        Positioned(
          left: -160,
          top: screenHeight * 0.17,
          child: Container(
            width: _orbitSize,
            height: _orbitSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: white.withValues(alpha: 0.08)),
              gradient: RadialGradient(
                colors: [
                  AppColors.accentTeal.themeColor.withValues(alpha: 0.145),
                  AppColors.accentTeal.themeColor.withValues(alpha: 0),
                ],
                stops: const [0, 0.7],
              ),
              boxShadow: [
                BoxShadow(
                  color: white.withValues(alpha: 0.012),
                  spreadRadius: 35,
                ),
                BoxShadow(
                  color: white.withValues(alpha: 0.008),
                  spreadRadius: 70,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.color});

  static const double _step = 43;

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    for (double x = 0; x <= size.width; x += _step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += _step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) =>
      oldDelegate.color != color;
}
