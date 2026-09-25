import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

/// Gradient CTA that opens the profile editor.
class EditProfileButton extends StatelessWidget {
  final VoidCallback? onTap;

  const EditProfileButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          gradient: const LinearGradient(
            colors: [Color(0xFF17B78F), Color(0xFF0E8F82)],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12.r),
            onTap: onTap ?? () {},
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.description_outlined,
                      size: 18.sp, color: Colors.white),
                  SizedBox(width: 8.w),
                  AppText(
                    LocaleKeys.home_edit_profile.tr(),
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
