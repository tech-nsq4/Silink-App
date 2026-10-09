import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/client_model.dart';
import 'client_avatar.dart';
import 'client_info_pill.dart';

class ClientContactCard extends StatelessWidget {
  const ClientContactCard({super.key, required this.client});

  final ClientModel client;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    final secondary = AppColors.textSecondaryColor.themeColor;
    final email = client.email.trim();
    final whatsapp = client.whatsapp.trim();
    final note = client.note.trim();
    final tags = client.categories.map((c) => c.name).join(' · ');
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.studioPanelBorder.themeColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClientAvatar(name: client.name, size: 46),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      client.name,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                    ),
                    if (tags.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      AppText(tags, fontSize: 9.sp, color: secondary),
                    ],
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ClientInfoPill(
            text: client.mobile,
            icon: AppImages.iconsCall,
            iconColor: accent,
          ),
          if (whatsapp.isNotEmpty && whatsapp != client.mobile) ...[
            SizedBox(height: 8.h),
            ClientInfoPill(
              text: whatsapp,
              icon: AppImages.iconsChat,
              iconColor: AppColors.whatsapp.themeColor,
            ),
          ],
          if (email.isNotEmpty) ...[
            SizedBox(height: 8.h),
            ClientInfoPill(
              text: email,
              icon: AppImages.iconsGmail,
              iconColor: accent,
            ),
          ],
          if (note.isNotEmpty) ...[
            SizedBox(height: 8.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: ColoredBox(
                color: AppColors.studioSelectFill.themeColor,
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                LocaleKeys.clientsHub_message.tr(),
                                fontSize: 8.5.sp,
                                fontWeight: FontWeight.w700,
                                color: secondary,
                              ),
                              SizedBox(height: 6.h),
                              AppText(note, fontSize: 10.5.sp, height: 1.6),
                            ],
                          ),
                        ),
                      ),
                      Container(width: 3.w, color: accent),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
