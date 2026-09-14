import 'package:Silink/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class SummaryRow {
  final String label;
  final String value;
  final ColorModel? valueColor;

  const SummaryRow({required this.label, required this.value, this.valueColor});
}

class PerformanceSummaryCard extends StatelessWidget {
  final String title;
  final List<SummaryRow> rows;

  const PerformanceSummaryCard({
    super.key,
    required this.title,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: 8.w.paddingVert + 16.w.paddingHorizontal,
            child: AppText(
              title,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Divider(
            height: 1,
          ),
          8.height,
          for (int i = 0; i < rows.length; i++) ...[
            Padding(
              padding: 16.w.paddingHorizontal + 6.paddingVert,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    rows[i].value,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: rows[i].valueColor?.themeColor ??
                        AppColors.textPrimaryColor.themeColor,
                  ),
                  AppText(
                    rows[i].label,
                    fontSize: 13.sp,
                  ),
                ],
              ),
            ),
            if (i != rows.length - 1)
              Divider(
                height: 8.h,
              ),
          ],
          6.height,
        ],
      ),
    );
  }
}
