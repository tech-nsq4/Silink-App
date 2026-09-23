import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyDashboardCard extends StatelessWidget {
  const CompanyDashboardCard({super.key, required this.companyName});

  final String companyName;

  @override
  Widget build(BuildContext context) {
    final name = companyName.trim().isEmpty ? 'Q' : companyName.trim();
    final initial = companyName.trim().isEmpty ? 'Q' : companyName.trim()[0];
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff2C9092), Color(0xff2368E2)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 52.w,
            height: 52.w,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: AppText(
                initial,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  name,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                4.height,
                const AppText(
                  'test',
                  fontSize: 11.5,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: const Row(
              children: [
                Icon(Icons.verified, color: Colors.white, size: 22),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
