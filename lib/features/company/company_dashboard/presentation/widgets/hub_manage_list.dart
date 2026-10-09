import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/app_text.dart';

class HubManageItem {
  const HubManageItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
}

class HubManageList extends StatelessWidget {
  const HubManageList({super.key, required this.items});

  final List<HubManageItem> items;

  @override
  Widget build(BuildContext context) {
    final secondary = AppColors.textSecondaryColor.themeColor;
    return Column(
      children: [
        for (final item in items)
          InkWell(
            onTap: item.onTap,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 18.h),
              decoration: BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(color: AppColors.studioStepLine.themeColor),
                ),
              ),
              child: Row(
                children: [
                  Icon(item.icon, size: 20.sp, color: secondary),
                  14.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(item.title,
                            fontSize: 11.sp, fontWeight: FontWeight.w800),
                        SizedBox(height: 5.h),
                        AppText(item.subtitle,
                            fontSize: 8.5.sp, color: secondary),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_left_rounded,
                      size: 20.sp, color: secondary),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
