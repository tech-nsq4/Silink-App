import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class AccountMenuTile extends StatelessWidget {
  const AccountMenuTile({
    super.key,
    required this.label,
    this.onTap,
    this.isDestructive = false,
    this.showChevron = true,
    required this.icon,
    this.value,
  });

  final String label;
  final VoidCallback? onTap;
  final bool isDestructive;
  final bool showChevron;
  final String icon;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 36.w,
            height: 36.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.fieldFill,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              icon,
              height: 17.h,
            ),
          ),
          12.width,
          AppText(
            label,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: isDestructive ? AppColors.errorColor.themeColor : null,
          ),
          Spacer(),
          if (value != null) ...[
            AppText(
              value!,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondaryColor.themeColor,
            ),
            8.width,
          ],
          Icon(
            Icons.arrow_forward_ios,
            size: 12.sp,
            color: AppColors.hintColor.themeColor,
          ),
        ],
      ),
    );
    if (onTap == null) {
      return content;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: content,
    );
  }
}
