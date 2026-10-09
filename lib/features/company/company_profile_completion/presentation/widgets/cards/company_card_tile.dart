import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/custom_tap_effect.dart';
import 'package:Silink/core/widgets/gradient_action_button.dart';

import 'company_card_status.dart';

class CompanyCardTile extends StatelessWidget {
  const CompanyCardTile({
    super.key,
    required this.card,
    this.onStatusChanged,
  });

  final CompanyCardItem card;
  final ValueChanged<CompanyCardStatus>? onStatusChanged;

  bool get _isSuspended => card.status == CompanyCardStatus.suspended;

  void _toggle() {
    onStatusChanged?.call(
      _isSuspended ? CompanyCardStatus.available : CompanyCardStatus.suspended,
    );
    AppOverlay.showSuccess(
      _isSuspended
          ? LocaleKeys.company_card_activated.tr()
          : LocaleKeys.company_card_deactivated.tr(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = companyCardStatusColor(card.status);
    final secondary = AppColors.textSecondaryColor.themeColor;
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
              Container(
                width: 40.w,
                height: 40.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child:
                    Icon(Icons.contactless_outlined, size: 20.sp, color: color),
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: AppText(
                            card.displayLabel,
                            fontSize: 11.5.sp,
                            fontWeight: FontWeight.w800,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        8.width,
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: AppText(
                            card.displayStatus,
                            fontSize: 7.5.sp,
                            fontWeight: FontWeight.w800,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    AppText(card.serial, fontSize: 8.5.sp, color: secondary),
                    SizedBox(height: 4.h),
                    AppText(
                      companyCardStatusHint(card.status),
                      fontSize: 8.5.sp,
                      color: secondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          if (_isSuspended)
            GradientActionButton(
              title: LocaleKeys.companyHub_activate.tr(),
              centerTitle: true,
              radius: 14,
              minHeight: 44,
              onTap: _toggle,
            )
          else
            CustomTapEffect(
              onTap: _toggle,
              child: Container(
                height: 46.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.white.themeColor,
                  borderRadius: BorderRadius.circular(14.r),
                  border:
                      Border.all(color: AppColors.studioPanelBorder.themeColor),
                ),
                child: AppText(
                  LocaleKeys.companyHub_stop.tr(),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
