import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class ClientAvatar extends StatelessWidget {
  const ClientAvatar({super.key, required this.name, this.size = 44});

  final String name;
  final double size;

  @override
  Widget build(BuildContext context) {
    final trimmed = name.trim();
    final initial =
        trimmed.isEmpty ? '' : trimmed.characters.first.toUpperCase();
    return Container(
      width: size.w,
      height: size.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accentTeal.themeColor,
            AppColors.accentBlue.themeColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular((size * 0.28).r),
      ),
      child: AppText(
        initial,
        fontSize: (size * 0.4).sp,
        fontWeight: FontWeight.w800,
        color: AppColors.white.themeColor,
      ),
    );
  }
}
