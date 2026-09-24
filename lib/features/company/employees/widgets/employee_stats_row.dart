import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeStatsRow extends StatelessWidget {
  const EmployeeStatsRow({
    super.key,
    required this.visitsLabel,
    required this.leadsLabel,
    required this.visits,
    required this.leads,
  });

  final String visitsLabel;
  final String leadsLabel;
  final int visits;
  final int leads;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatCard(label: visitsLabel, value: visits),
        12.width,
        _StatCard(label: leadsLabel, value: leads),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 68.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.cardColor.themeColor,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.borderColor.themeColor),
        ),
        child: Column(
          children: [
            AppText(
              '$value',
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
            ),
            3.height,
            AppText(
              label,
              fontSize: 10.sp,
              color: AppColors.textSecondaryColor.themeColor,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
