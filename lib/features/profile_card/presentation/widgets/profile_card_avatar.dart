import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/image/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCardAvatar extends StatelessWidget {
  const ProfileCardAvatar({
    super.key,
    required this.size,
    required this.fullName,
    required this.photoUrl,
    required this.backgroundColor,
    required this.fontFamily,
  });

  final double size;
  final String fullName;
  final String? photoUrl;
  final Color backgroundColor;
  final String? fontFamily;

  bool get _hasPhoto => photoUrl != null && photoUrl!.trim().isNotEmpty;

  String get _initial {
    final name = fullName.trim();
    return name.isEmpty ? '' : name.characters.first.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final white = AppColors.white.themeColor;
    final innerRadius = 18.r;

    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(innerRadius + 3.w),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.themeColor.withValues(alpha: 0.12),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: _hasPhoto
          ? CustomImage(
              image: photoUrl!,
              radius: innerRadius,
              width: size,
              height: size,
            )
          : Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(innerRadius),
              ),
              child: AppText(
                _initial,
                fontSize: 28.sp,
                fontWeight: FontWeight.w800,
                color: white,
                fontFamily: fontFamily,
              ),
            ),
    );
  }
}
