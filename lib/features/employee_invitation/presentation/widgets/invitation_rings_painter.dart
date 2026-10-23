import 'dart:math' as math;

import 'package:flutter/material.dart';

class InvitationRingsPainter extends CustomPainter {
  const InvitationRingsPainter({
    required this.progress,
    required this.centerAlignmentY,
    required this.scale,
    required this.ringColor,
    required this.dotColor,
    required this.accentColor,
  });

  final double progress;
  final double centerAlignmentY;
  final double scale;
  final Color ringColor;
  final Color dotColor;
  final Color accentColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center =
        Offset(size.width / 2, (centerAlignmentY + 1) / 2 * size.height);
    _paintPulses(canvas, center);
    _paintOrbit(canvas, center);
  }

  void _paintPulses(Canvas canvas, Offset center) {
    const rings = 3;
    for (var i = 0; i < rings; i++) {
      final phase = (progress + i / rings) % 1;
      final radius = (56 + phase * 96) * scale;
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4 * scale
        ..color = ringColor.withValues(alpha: (1 - phase) * 0.45);
      canvas.drawCircle(center, radius, paint);
    }
  }

  void _paintOrbit(Canvas canvas, Offset center) {
    final orbitRadius = 84 * scale;
    final guide = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1 * scale
      ..color = ringColor.withValues(alpha: 0.18);
    canvas.drawCircle(center, orbitRadius, guide);

    const dots = 5;
    for (var i = 0; i < dots; i++) {
      final angle = 2 * math.pi * (progress + i / dots);
      final offset =
          center + Offset(math.cos(angle), math.sin(angle)) * orbitRadius;
      final isAccent = i.isEven;
      final paint = Paint()
        ..color = (isAccent ? ringColor : dotColor)
            .withValues(alpha: isAccent ? 0.95 : 0.55);
      canvas.drawCircle(offset, (isAccent ? 4.5 : 3) * scale, paint);
    }
  }

  @override
  bool shouldRepaint(InvitationRingsPainter old) => old.progress != progress;
}
