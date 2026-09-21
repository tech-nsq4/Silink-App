import 'package:Silink/core/utils/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class CardStatsRow extends StatelessWidget {
  const CardStatsRow({
    super.key,
    required this.date,
    required this.clientsCount,
    required this.visitsCount,
  });

  final DateTime date;
  final int clientsCount;
  final int visitsCount;

  @override
  Widget build(BuildContext context) {
    final formatted = DateFormat('yyyy/M/d').format(date);
    return Row(
      children: [
        Icon(Icons.calendar_today_outlined,
            size: 13.sp, color: AppColors.textSecondaryColor.themeColor),
        4.width,
        AppText(formatted,
            fontSize: 11.sp, color: AppColors.textSecondaryColor.themeColor),
        12.width,
        Icon(Icons.people_outline,
            size: 14.sp, color: AppColors.textSecondaryColor.themeColor),
        4.width,
        AppText(
            '$clientsCount ${LocaleKeys.myCards_clientsCount.tr()}',
            fontSize: 11.sp, color: AppColors.textSecondaryColor.themeColor),
        12.width,
        Icon(Icons.remove_red_eye_outlined,
            size: 14.sp, color: AppColors.textSecondaryColor.themeColor),
        4.width,
        AppText(
            '$visitsCount ${LocaleKeys.myCards_visitsCount.tr()}',
            fontSize: 11.sp, color: AppColors.textSecondaryColor.themeColor),
      ],
    );
  }
}