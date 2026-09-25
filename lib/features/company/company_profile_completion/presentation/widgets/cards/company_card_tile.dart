import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'company_card_status.dart';

/// A personal NFC card row with its status and activation action.
class CompanyCardTile extends StatelessWidget {
  const CompanyCardTile({
    super.key,
    required this.card,
    this.onStatusChanged,
  });

  final CompanyCardItem card;
  final ValueChanged<CompanyCardStatus>? onStatusChanged;

  Color get _accentColor => companyCardStatusColor(card.status);

  @override
  Widget build(BuildContext context) {
    final accentColor = _accentColor;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.cardColor.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: SvgPicture.asset(
                  AppImages.iconsCard,
                  width: 23.w,
                  height: 23.h,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(accentColor, BlendMode.srcIn),
                ),
              ),
              10.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: AppText(
                            card.displayLabel,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        8.width,
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: accentColor.withValues(alpha: 0.09),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: AppText(
                            card.displayStatus,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            color: accentColor,
                          ),
                        ),
                      ],
                    ),
                    6.height,
                    AppText(
                      card.serial,
                      fontSize: 12.sp,
                      color: AppColors.textSecondaryColor.themeColor,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          12.height,
          _buildAction(accentColor),
        ],
      ),
    );
  }

  Widget _buildAction(Color accentColor) {
    final isActive = card.status == CompanyCardStatus.active;
    return CustomButton(
      onTap: () {
        final nextStatus =
            isActive ? CompanyCardStatus.suspended : CompanyCardStatus.active;
        onStatusChanged?.call(nextStatus);
        AppOverlay.showSuccess(
          isActive
              ? LocaleKeys.company_card_deactivated.tr()
              : LocaleKeys.company_card_activated.tr(),
        );
      },
      title: isActive
          ? LocaleKeys.company_deactivate.tr()
          : LocaleKeys.company_activate.tr(),
      isOutlined: isActive,
      color: isActive ? Colors.transparent : AppColors.blue.themeColor,
      borderColor: accentColor.withValues(alpha: 0.28),
      textColor: isActive ? accentColor : Colors.white,
      height: 42,
      radius: 12,
      fontSize: 12.5,
    );
  }
}
