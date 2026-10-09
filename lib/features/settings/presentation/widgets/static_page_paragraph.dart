import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class StaticPageParagraph extends StatelessWidget {
  const StaticPageParagraph({
    super.key,
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:4.paddingTop,
              child: Icon(Icons.circle,size: 12,),
            ),
            5.width,
            AppText(
              title,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimaryColor.themeColor,
            ),
          ],
        ),
        6.height,
        AppText(
          body,
          fontSize: 14.sp,
          height: 1.8,
          color: AppColors.textSecondaryColor.themeColor,
        ),
      ],
    );
  }
}
