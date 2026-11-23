import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/studio_platform.dart';

class StudioLinkPreview extends StatelessWidget {
  const StudioLinkPreview({
    super.key,
    required this.link,
    required this.color,
  });

  final String link;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
      alignment: Alignment.topCenter,
      child: link.isEmpty
          ? const SizedBox(width: double.infinity)
          : Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(9.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.link_rounded, size: 16.sp, color: color),
                  8.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          LocaleKeys.cardStudio_linkPreview.tr(),
                          fontSize: 8.sp,
                          color: AppColors.studioFieldHint.themeColor,
                        ),
                        2.height,
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: AppText(
                            StudioPlatform.displayLink(link),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.studioFieldText.themeColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.check_circle_rounded, size: 16.sp, color: color),
                ],
              ),
            ),
    );
  }
}
