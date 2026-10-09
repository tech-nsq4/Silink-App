import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../data/models/static_page_content.dart';
import 'widgets/static_page_paragraph.dart';

class StaticPageScreen extends StatelessWidget {
  const StaticPageScreen({super.key, required this.type});

  final StaticPageType type;

  @override
  Widget build(BuildContext context) {
    final content = StaticPageContent.of(type);
    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(title: content.titleKey.tr()),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 20.h),
              children: [
                AppText(
                  content.introKey.tr(),
                  fontSize: 14.sp,
                  height: 1.8,
                  color: AppColors.textSecondaryColor.themeColor,
                ),
                for (final section in content.sections) ...[
                  24.height,
                  StaticPageParagraph(
                    title: section.titleKey.tr(),
                    body: section.bodyKey.tr(),
                  ),
                ],
                24.height,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
