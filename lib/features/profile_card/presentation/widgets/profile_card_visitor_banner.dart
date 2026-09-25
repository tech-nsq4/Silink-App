import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCardVisitorBanner extends StatelessWidget
    implements PreferredSizeWidget {
  const ProfileCardVisitorBanner({super.key});

  @override
  Size get preferredSize => Size.fromHeight(34.h);

  @override
  Widget build(BuildContext context) {
    final mint = AppColors.mint.themeColor;

    return Container(
      color: AppColors.mintSoft.themeColor,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: preferredSize.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.visibility_outlined, size: 14.sp, color: mint),
              6.width,
              Flexible(
                child: AppText(
                  LocaleKeys.publish_visitorBanner.tr(),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: mint,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
