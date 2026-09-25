import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileCardActionButton extends StatelessWidget {
  const ProfileCardActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.buttonShape,
    required this.onTap,
    this.fontFamily,
  });

  final String icon;
  final String label;
  final Color color;
  final String buttonShape;
  final VoidCallback onTap;
  final String? fontFamily;

  BorderRadius? get _radius => switch (buttonShape) {
        'square' => BorderRadius.circular(12.r),
        'curved' => BorderRadius.circular(18.r),
        _ => null,
      };

  @override
  Widget build(BuildContext context) {
    final radius = _radius;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: SizedBox(
        width: 72.w,
        child: Column(
          children: [
            Container(
              width: 54.w,
              height: 54.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                shape: radius == null ? BoxShape.circle : BoxShape.rectangle,
                borderRadius: radius,
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: SvgPicture.asset(
                icon,
                width: 22.w,
                height: 22.w,
                colorFilter: ColorFilter.mode(
                  AppColors.white.themeColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            8.height,
            AppText(
              label,
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
              fontFamily: fontFamily,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
