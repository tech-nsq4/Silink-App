import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileCardGradientButton extends StatelessWidget {
  const ProfileCardGradientButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.enabled = true,
    this.loading = false,
  });

  final String label;
  final String icon;
  final VoidCallback onTap;
  final bool enabled;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final white = AppColors.white.themeColor;
    final active = enabled && !loading;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: enabled ? 1 : 0.45,
      child: InkWell(
        onTap: active ? onTap : null,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          height: 54.h,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            gradient: LinearGradient(
              colors: [AppColors.mint.themeColor, AppColors.blue.themeColor],
            ),
            boxShadow: enabled
                ? [
                    BoxShadow(
                      color: AppColors.blue.themeColor.withValues(alpha: 0.25),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: loading
              ? CustomLoadingWidget(color: white, size: 24)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      icon,
                      width: 18.w,
                      height: 18.w,
                      colorFilter: ColorFilter.mode(white, BlendMode.srcIn),
                    ),
                    10.width,
                    AppText(
                      label,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: white,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
