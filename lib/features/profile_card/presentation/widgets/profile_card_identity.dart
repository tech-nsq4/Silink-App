import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCardIdentity extends StatelessWidget {
  const ProfileCardIdentity({
    super.key,
    required this.fullName,
    required this.jobTitle,
    required this.company,
    required this.fontFamily,
  });

  final String fullName;
  final String jobTitle;
  final String company;
  final String? fontFamily;

  String get _subtitle => [jobTitle.trim(), company.trim()]
      .where((part) => part.isNotEmpty)
      .join(' · ');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 24.paddingHorizontal,
      child: Column(
        children: [
          AppText(
            fullName.trim(),
            fontSize: 22.sp,
            fontWeight: FontWeight.w800,
            textAlign: TextAlign.center,
            fontFamily: fontFamily,
            maxLines: 2,
          ),
          if (_subtitle.isNotEmpty) ...[
            4.height,
            AppText(
              _subtitle,
              fontSize: 14.sp,
              color: AppColors.textSecondaryColor.themeColor,
              textAlign: TextAlign.center,
              fontFamily: fontFamily,
              maxLines: 2,
            ),
          ],
        ],
      ),
    );
  }
}
