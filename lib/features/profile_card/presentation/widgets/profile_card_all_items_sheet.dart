import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/profile_card/data/models/profile_card_product.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'profile_card_product_card.dart';

class ProfileCardAllItemsSheet extends StatelessWidget {
  const ProfileCardAllItemsSheet({
    super.key,
    required this.items,
    required this.primaryColor,
    required this.fontFamily,
    required this.onItemTap,
  });

  final List<ProfileCardProduct> items;
  final Color primaryColor;
  final String? fontFamily;
  final ValueChanged<ProfileCardProduct> onItemTap;

  static Future<void> show(
    BuildContext context, {
    required List<ProfileCardProduct> items,
    required Color primaryColor,
    required String? fontFamily,
    required ValueChanged<ProfileCardProduct> onItemTap,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white.themeColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (_) => ProfileCardAllItemsSheet(
        items: items,
        primaryColor: primaryColor,
        fontFamily: fontFamily,
        onItemTap: onItemTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final spacing = 12.w;
    final cardWidth = (MediaQuery.sizeOf(context).width - 32.w - spacing) / 2;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.85,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            12.height,
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.dividerColor.themeColor,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            16.height,
            AppText(
              LocaleKeys.publish_productsAndServices.tr(),
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
              fontFamily: fontFamily,
            ),
            16.height,
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
                child: Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: [
                    for (final item in items)
                      ProfileCardProductCard(
                        product: item,
                        primaryColor: primaryColor,
                        fontFamily: fontFamily,
                        cardWidth: cardWidth,
                        onTap: () => onItemTap(item),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
