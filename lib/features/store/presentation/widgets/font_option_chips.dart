import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/product_font.dart';

class FontOptionChips extends StatelessWidget {
  const FontOptionChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final ProductFont selected;
  final ValueChanged<ProductFont> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final font in ProductFont.values) ...[
          Expanded(
            child: InkWell(
              onTap: () => onSelected(font),
              borderRadius: BorderRadius.circular(14.r),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: font == selected
                      ? AppColors.mintSoft.themeColor
                      : AppColors.cardColor.themeColor,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: font == selected
                        ? AppColors.brandTeal.themeColor
                        : AppColors.borderColor.themeColor,
                  ),
                ),
                child: AppText(
                  font.labelKey.tr(),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: font.family,
                  color: font == selected
                      ? AppColors.mint.themeColor
                      : AppColors.textPrimaryColor.themeColor,
                ),
              ),
            ),
          ),
          if (font != ProductFont.values.last) 10.width,
        ],
      ],
    );
  }
}
