import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/locale_keys.dart';
import '../app_text.dart';
import 'public_profile_data.dart';

class PublicProfileContactBar extends StatelessWidget {
  const PublicProfileContactBar({
    super.key,
    required this.data,
    required this.onCall,
    required this.onEmail,
    required this.onSaveContact,
    required this.onShareData,
  });

  final PublicProfileData data;
  final VoidCallback onCall;
  final VoidCallback onEmail;
  final VoidCallback onSaveContact;
  final VoidCallback onShareData;

  @override
  Widget build(BuildContext context) {
    final actions = <(IconData, String, VoidCallback)>[
      if (data.phone.trim().isNotEmpty)
        (Icons.phone_outlined, LocaleKeys.publicProfile_call.tr(), onCall),
      if (data.email.trim().isNotEmpty)
        (
          Icons.mail_outline_rounded,
          LocaleKeys.publicProfile_email.tr(),
          onEmail
        ),
      (
        Icons.download_outlined,
        LocaleKeys.publicProfile_saveContact.tr(),
        onSaveContact
      ),
      (
        Icons.person_add_alt_outlined,
        LocaleKeys.publicProfile_shareData.tr(),
        onShareData
      ),
    ];
    return Container(
      margin: EdgeInsets.only(top: 20.h, bottom: 34.h),
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColors.profileLine.themeColor),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            for (final (index, action) in actions.indexed) ...[
              if (index > 0)
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: AppColors.profileContactDivider.themeColor,
                ),
              Expanded(
                child: GestureDetector(
                  onTap: action.$3,
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(action.$1, size: 18.sp, color: data.accent),
                      SizedBox(height: 9.h),
                      AppText(
                        action.$2,
                        fontSize: 8.sp,
                        color: AppColors.profileContactLabel.themeColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
