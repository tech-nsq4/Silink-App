import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class ShopTiltedCard extends StatelessWidget {
  const ShopTiltedCard({
    super.key,
    required this.color,
    required this.width,
    this.angle = -0.2,
  });

  final Color color;
  final double width;
  final double angle;

  @override
  Widget build(BuildContext context) {
    final isLight = color.computeLuminance() > 0.6;
    final ink =
        isLight ? AppColors.textPrimaryColor.themeColor : AppColors.white.light;
    final accent = AppColors.mint.themeColor;
    return Transform.rotate(
      angle: angle,
      child: Container(
        width: width,
        height: width / 1.6,
        padding: EdgeInsets.all(width * 0.08),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * 0.07),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.lerp(color, AppColors.white.light, 0.12)!,
              Color.lerp(color, AppColors.black.light, 0.18)!,
            ],
          ),
          border: Border.all(color: ink.withValues(alpha: 0.12)),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.light.withValues(alpha: 0.22),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppText(
                    'Silink',
                    fontSize: width * 0.075,
                    fontWeight: FontWeight.w800,
                    color: ink,
                  ),
                  SizedBox(width: width * 0.015),
                  Container(
                    width: width * 0.025,
                    height: width * 0.025,
                    decoration:
                        BoxDecoration(color: accent, shape: BoxShape.circle),
                  ),
                  const Spacer(),
                  Icon(Icons.contactless_outlined,
                      size: width * 0.09, color: ink.withValues(alpha: 0.7)),
                ],
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: width * 0.3,
                  height: width * 0.018,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
              SizedBox(height: width * 0.05),
              AppText(
                'YOUR NEXT CONNECTION',
                fontSize: width * 0.035,
                letterSpacing: 1.2,
                color: ink.withValues(alpha: 0.45),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
