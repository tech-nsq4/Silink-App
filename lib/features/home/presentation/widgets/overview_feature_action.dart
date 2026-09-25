import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class Features extends StatelessWidget {
  final String label;
  final String icon;
  final Function() onTap;

  const Features({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SvgPicture.asset(icon),
          4.height,
          AppText(
            label.tr(),
            fontSize: 11.2.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
        ],
      ),
    );
  }
}
