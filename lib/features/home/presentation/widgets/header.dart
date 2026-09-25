import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import 'home_greeting.dart';

class Header extends StatelessWidget {
  final String userName;

  const Header({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: HomeGreeting(name: userName)),
        SizedBox(width: 12.w),
        InkWell(
          onTap: () {},
          child: Container(
            height: 40.h,
            width: 40.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.white.themeColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.borderColor.themeColor,
              ),
            ),
            child: SvgPicture.asset(AppImages.iconsNotifications),
          ),
        ),
      ],
    );
  }
}
