import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/widgets/app_text.dart';

class ProfileActionButton extends StatelessWidget {
  final String icon;
  final String label;
  final Color backgroundColor;
  final VoidCallback onTap;

  const ProfileActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 54.w,
            height: 54.w,
            alignment: Alignment.center,
            decoration:
                BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
            child: SvgPicture.asset(icon),
          ),
          6.height,
          AppText(
            label,
            fontSize: 11.sp,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
