import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/app_colors.dart';
import '../utils/app_images.dart';

class ProductThumb extends StatelessWidget {
  const ProductThumb({
    super.key,
    required this.gradient,
    this.imageUrl = '',
    this.width,
    this.height,
    this.radius = 12,
    this.borderRadius,
    this.iconSize = 24,
  });

  final List<Color> gradient;
  final String imageUrl;
  final double? width;
  final double? height;
  final double radius;
  final BorderRadiusGeometry? borderRadius;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final resolvedRadius = borderRadius ?? BorderRadius.circular(radius.r);
    final placeholder = SvgPicture.asset(
      AppImages.iconsCard,
      height: iconSize.h,
      width: iconSize.w,
      colorFilter: ColorFilter.mode(
        AppColors.overlayOnDark.themeColor.withValues(alpha: 0.85),
        BlendMode.srcIn,
      ),
    );

    return Container(
      width: width?.w,
      height: height?.h,
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: resolvedRadius,
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: imageUrl.trim().isEmpty
          ? placeholder
          : Image.network(
              imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) =>
                  progress == null ? child : Center(child: placeholder),
              errorBuilder: (_, __, ___) => Center(child: placeholder),
            ),
    );
  }
}
