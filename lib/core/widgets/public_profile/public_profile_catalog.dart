import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/locale_keys.dart';
import '../app_text.dart';
import 'public_profile_data.dart';
import 'public_profile_item_card.dart';
import 'public_profile_section_head.dart';

class PublicProfileCatalog extends StatefulWidget {
  const PublicProfileCatalog({
    super.key,
    required this.items,
    required this.accent,
    required this.onItemTap,
  });

  final List<PublicProfileItem> items;
  final Color accent;
  final ValueChanged<PublicProfileItem> onItemTap;

  @override
  State<PublicProfileCatalog> createState() => _PublicProfileCatalogState();
}

class _PublicProfileCatalogState extends State<PublicProfileCatalog> {
  String? _kind;

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    final hasServices = items.any((i) => i.isService);
    final hasProducts = items.any((i) => !i.isService);
    final visible =
        _kind == null ? items : items.where((i) => i.kind == _kind).toList();
    final onlyProducts = !hasServices;

    final rows = <Widget>[];
    for (var i = 0; i < visible.length; i += 2) {
      rows.add(
        Padding(
          padding: EdgeInsets.only(bottom: 13.h),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _card(visible, i)),
                SizedBox(width: 11.w),
                Expanded(
                  child: i + 1 < visible.length
                      ? _card(visible, i + 1)
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 23.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PublicProfileSectionHead(
            eyebrow: LocaleKeys.publicProfile_catalogEyebrow.tr(),
            title: onlyProducts
                ? LocaleKeys.publicProfile_productsTitle.tr()
                : LocaleKeys.publicProfile_servicesTitle.tr(),
          ),
          if (hasServices && hasProducts)
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Wrap(
                spacing: 7.w,
                children: [
                  _tab(null, LocaleKeys.publicProfile_tabAll.tr()),
                  _tab('service', LocaleKeys.publicProfile_tabServices.tr()),
                  _tab('product', LocaleKeys.publicProfile_tabProducts.tr()),
                ],
              ),
            ),
          ...rows,
        ],
      ),
    );
  }

  Widget _card(List<PublicProfileItem> items, int index) =>
      PublicProfileItemCard(
        item: items[index],
        index: index,
        accent: widget.accent,
        onTap: () => widget.onItemTap(items[index]),
      );

  Widget _tab(String? kind, String label) {
    final active = _kind == kind;
    return GestureDetector(
      onTap: () => setState(() => _kind = kind),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: active ? widget.accent : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: active ? widget.accent : AppColors.assistantLine.themeColor,
          ),
        ),
        child: AppText(
          label,
          fontSize: 9.sp,
          color: active
              ? AppColors.white.light
              : AppColors.profileTabText.themeColor,
        ),
      ),
    );
  }
}
