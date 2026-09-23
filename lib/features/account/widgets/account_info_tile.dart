import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class AccountInfoTile extends StatelessWidget {
  const AccountInfoTile({
    super.key,
    required this.label,
    this.value,
    this.trailing,
    this.leading,
    this.onTap,
  });

  final String label;
  final String? value;
  final Widget? trailing;
  final Widget? leading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    final content = Padding(
      padding: EdgeInsets.symmetric(vertical: 13.h),
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            12.width,
          ],
          Expanded(
            child: AppText(
              label,
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          8.width,
          trailing ??
              (value != null
                  ? AppText(
                      value!,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondaryColor.themeColor,
                    )
                  : Icon(
                      isRtl
                          ? Icons.chevron_left_rounded
                          : Icons.chevron_right_rounded,
                      size: 20.sp,
                      color: AppColors.hintColor.themeColor,
                    )),
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
