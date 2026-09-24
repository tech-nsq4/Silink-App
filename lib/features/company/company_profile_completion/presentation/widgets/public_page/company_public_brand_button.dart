import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CompanyPublicBrandButton extends StatelessWidget {
  const CompanyPublicBrandButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final String icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: onTap,
      height: 48,
      radius: 16,
      color: AppColors.companyBrand.themeColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 17.w,
            height: 17.w,
            colorFilter: ColorFilter.mode(
              AppColors.overlayOnDark.themeColor,
              BlendMode.srcIn,
            ),
          ),
          8.width,
          AppText(
            label,
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.overlayOnDark.themeColor,
          ),
        ],
      ),
    );
  }
}
