import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';

class AccountDangerCard extends StatelessWidget {
  const AccountDangerCard({
    super.key,
    required this.title,
    required this.editLabel,
    required this.deleteLabel,
    this.onEditTap,
    this.onDeleteTap,
  });

  final String title;
  final String editLabel;
  final String deleteLabel;
  final VoidCallback? onEditTap;
  final VoidCallback? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: AppColors.saleRed.themeColor.withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppText(
            title,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            height: 1.6,
          ),
          12.height,
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  title: editLabel,
                  onTap: onEditTap ?? () {},
                  isOutlined: true,
                  color: Colors.transparent,
                  borderColor: AppColors.dividerColor.themeColor,
                  textColor: AppColors.textSecondaryColor.themeColor,
                  height: 40,
                  radius: 12,
                  fontSize: 13,
                ),
              ),
              10.width,
              Expanded(
                child: CustomButton(
                  title: deleteLabel,
                  onTap: onDeleteTap ?? () {},
                  color: AppColors.saleRed.themeColor,
                  borderColor: AppColors.saleRed.themeColor,
                  height: 40,
                  radius: 12,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
