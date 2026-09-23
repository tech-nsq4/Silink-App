import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/clients/models/client_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.client});

  final ClientModel client;

  @override
  Widget build(BuildContext context) {
    final email = (client.email ?? '').trim();
    final company = (client.company ?? '').trim();
    final role = (client.role ?? '').trim();
    final message = (client.message ?? '').trim();
    // أول حرف من اسم العميل — يُعرض داخل الأفاتار المتدرج بدل أيقونة الشخص.
    final name = client.name.trim();
    final initial = name.isEmpty ? '' : name.characters.first.toUpperCase();
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 52.w,
                height: 52.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff2C9092), Color(0xff2368E2)],
                    begin: Alignment.topLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: AppText(
                  initial,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.white.themeColor,
                ),
              ),
              12.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    client.name,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  if (role.isNotEmpty) ...[
                    2.height,
                    AppText(
                      role,
                      fontSize: 12.sp,
                    ),
                  ],
                  if (company.isNotEmpty) ...[
                    2.height,
                    AppText(
                      company,
                      fontSize: 12.sp,
                      color: AppColors.textSecondaryColor.themeColor,
                    ),
                  ],
                ],
              ),
            ],
          ),
          16.height,
          InfoPill(
            text: client.phone,
            icon: AppImages.iconsCall,
            iconColor: AppColors.mint.themeColor,
          ),
          if (email.isNotEmpty) ...[
            8.height,
            InfoPill(
              text: email,
              icon: AppImages.iconsGmail,
              iconColor: AppColors.blue.themeColor,
            ),
          ],
          if (message.isNotEmpty) ...[
            10.height,
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.fieldFill,
                borderRadius: BorderRadius.circular(12.r),
                border: BorderDirectional(
                  start: BorderSide(
                    color: AppColors.mint.themeColor,
                    width: 2.w,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    LocaleKeys.clients_message.tr(),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textSecondaryColor.themeColor,
                  ),
                  6.height,
                  AppText(
                    message,
                    fontSize: 14.sp,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class InfoPill extends StatelessWidget {
  const InfoPill({
    super.key,
    required this.text,
    required this.icon,
    this.iconColor,
  });

  final String text;
  final String icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(
                iconColor ?? AppColors.textPrimaryColor.themeColor,
                BlendMode.srcIn),
          ),
          8.width,
          AppText(
            text,
            textAlign: TextAlign.start,
            fontSize: 14.sp,
          ),
        ],
      ),
    );
  }
}
