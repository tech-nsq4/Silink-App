import 'package:Silink/features/my_card/widgets/link_copy_pill.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';

class PublishSuccessBanner extends StatelessWidget {
  const PublishSuccessBanner({
    super.key,
    required this.handle,
  });
  final String handle;
  String get _fullLink => '$handle/silink.sa';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.mint.themeColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.mint.themeColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                alignment: Alignment.center,
                decoration:  BoxDecoration(
                  color: AppColors.mint.themeColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_circle_outline, size: 18.sp, color: Colors.white),
              ),
              8.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      LocaleKeys.publish_publishedSuccessTitle.tr(),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0B7A46),
                    ),
                    4.height,
                    AppText(
                      LocaleKeys.publish_publishedSuccessSubtitle.tr(),
                      fontSize: 12.sp,
                      color: AppColors.mint.themeColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          6.height,
          LinkCopyPill(fullLink: _fullLink),
        ],
      ),
    );
  }
}
