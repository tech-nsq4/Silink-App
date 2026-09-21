import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text.dart';

class StoreActionBar extends StatelessWidget {
  const StoreActionBar({
    super.key,
    required this.title,
    required this.onTap,
    this.secondaryTitle,
    this.onSecondaryTap,
    this.loading = false,
  });

  final String title;
  final VoidCallback onTap;
  final String? secondaryTitle;
  final VoidCallback? onSecondaryTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 19.paddingHorizontal + 12.paddingVert,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomButton(onTap: onTap, title: title, loading: loading),
          if (secondaryTitle != null && onSecondaryTap != null) ...[
            10.height,
            InkWell(
              onTap: onSecondaryTap,
              child: Center(
                child: AppText(
                  secondaryTitle!,
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.mint.themeColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
