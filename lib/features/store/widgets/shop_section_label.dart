import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/app_text.dart';

class ShopSectionLabel extends StatelessWidget {
  const ShopSectionLabel({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: AppText(text, fontSize: 10.sp, fontWeight: FontWeight.w800),
    );
  }
}
