import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class ClientInfoPill extends StatelessWidget {
  const ClientInfoPill({
    super.key,
    required this.text,
    required this.icon,
    this.iconColor,
  });

  final String text;
  final String icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.studioSelectFill.themeColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.studioPanelBorder.themeColor),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            height: 16.h,
            colorFilter: ColorFilter.mode(
              iconColor ?? AppColors.textPrimaryColor.themeColor,
              BlendMode.srcIn,
            ),
          ),
          8.width,
          Expanded(
            child: AppText(
              text,
              textAlign: TextAlign.start,
              fontSize: 10.5.sp,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
