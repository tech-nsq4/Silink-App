import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class ShopInfoTab {
  const ShopInfoTab(
      {required this.label, required this.lines, this.checks = false});

  final String label;
  final List<String> lines;
  final bool checks;
}

class ShopInfoTabs extends StatefulWidget {
  const ShopInfoTabs({super.key, required this.tabs});

  final List<ShopInfoTab> tabs;

  @override
  State<ShopInfoTabs> createState() => _ShopInfoTabsState();
}

class _ShopInfoTabsState extends State<ShopInfoTabs> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    final line = AppColors.studioStepLine.themeColor;
    final secondary = AppColors.textSecondaryColor.themeColor;
    final tab = widget.tabs[_index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: line)),
          ),
          child: Row(
            children: [
              for (final (index, item) in widget.tabs.indexed)
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _index = index),
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: AppText(
                            item.label,
                            fontSize: 9.5.sp,
                            fontWeight: index == _index
                                ? FontWeight.w800
                                : FontWeight.w500,
                            color: index == _index ? accent : secondary,
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          height: 2,
                          color: index == _index ? accent : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.topCenter,
          child: Padding(
            key: ValueKey(_index),
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final text in tab.lines)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (tab.checks) ...[
                          Icon(Icons.check_rounded, size: 13.sp, color: accent),
                          8.width,
                        ],
                        Expanded(
                          child: AppText(
                            text,
                            fontSize: 9.5.sp,
                            height: 1.7,
                            color: secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
