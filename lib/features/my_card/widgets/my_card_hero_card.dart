import 'package:Silink/core/utils/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/image/custom_image.dart';
import '../models/my_card_model.dart';
import 'my_card_small_pill.dart';

class MyCardHeroCard extends StatelessWidget {
  const MyCardHeroCard({
    super.key,
    required this.card,
    required this.statusLabel,
    required this.categoryLabels,
  });

  final MyCardModel card;
  final String statusLabel;
  final List<String> categoryLabels;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 92.h,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16.r)),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFF17B78F), Color(0xFF2F6FED)],
                  ),
                ),
              ),
              PositionedDirectional(
                start: 16.w,
                bottom: -28.h,
                child: Container(
                  width: 64.w,
                  height: 64.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: card.avatarColor,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: AppColors.white.themeColor,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.10),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: card.hasImage
                      ? CustomImage(
                          image: card.imageUrl!,
                          width: 64.w,
                          height: 64.w,
                          radius: 11.r,
                        )
                      : AppText(
                          card.initials,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 38.h, 16.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8.w,
                  runSpacing: 6.h,
                  children: [
                    MyCardSmallPill(
                      label: statusLabel,
                      background: const Color(0xFFE7F8F0),
                      textColor: const Color(0xFF17B78F),
                    ),
                    if (card.isDefault)
                      MyCardSmallPill(
                        label: LocaleKeys.myCards_isDefault.tr(),
                        background: const Color(0xFFE8F0FE),
                        textColor: const Color(0xFF2F6FED),
                      ),
                    for (final label in categoryLabels)
                      MyCardSmallPill(
                        label: label,
                        background: const Color(0xFFE7F8F0),
                        textColor: const Color(0xFF17B78F),
                      ),
                  ],
                ),
                12.height,
                AppText(
                  card.name,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  textAlign: TextAlign.start,
                ),
                2.height,
                if (card.role.trim().isNotEmpty)
                  AppText(
                    card.role,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondaryColor.themeColor,
                    textAlign: TextAlign.start,
                  ),
                if (card.company.trim().isNotEmpty)
                  AppText(
                    card.company,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondaryColor.themeColor,
                    textAlign: TextAlign.start,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
