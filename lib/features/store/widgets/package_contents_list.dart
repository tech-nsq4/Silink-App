import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class PackageContentsList extends StatelessWidget {
  const PackageContentsList({super.key, required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int index = 0; index < items.length; index++) ...[
          Row(
            children: [
              Container(
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                  color: AppColors.mint.themeColor,
                  shape: BoxShape.circle,
                ),
              ),
              8.width,
              Expanded(
                child: AppText(
                  items[index],
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          if (index != items.length - 1) 6.height,
        ],
      ],
    );
  }
}
