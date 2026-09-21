import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';

class ProductThumb extends StatelessWidget {
  const ProductThumb({
    super.key,
    required this.gradient,
    this.width,
    this.height,
    this.radius = 12,
    this.iconSize = 24,
  });

  final List<Color> gradient;
  final double? width;
  final double? height;
  final double radius;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width?.w,
      height: height?.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius.r),
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SvgPicture.asset(
        AppImages.iconsCard,
        height: iconSize.h,
        width: iconSize.w,
        colorFilter: ColorFilter.mode(
          AppColors.overlayOnDark.themeColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
