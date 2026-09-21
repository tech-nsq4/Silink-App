import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/navigation_services.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/convert_helper.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../models/product.dart';
import '../models/product_font.dart';
import '../models/store_catalog.dart';
import '../widgets/card_design_preview.dart';
import '../widgets/customization_tool_tile.dart';
import '../widgets/font_option_chips.dart';
import '../widgets/product_color_swatches.dart';
import '../widgets/store_action_bar.dart';
import '../widgets/store_section_card.dart';

class CardCustomizationScreen extends StatefulWidget {
  const CardCustomizationScreen({super.key, required this.productId});

  final String productId;

  @override
  State<CardCustomizationScreen> createState() =>
      _CardCustomizationScreenState();
}

class _CardCustomizationScreenState extends State<CardCustomizationScreen> {
  final _nameCtrl = TextEditingController();
  final _jobTitleCtrl = TextEditingController();
  final _companyCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  ProductFont _font = ProductFont.tajawal;
  int? _colorIndex;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _jobTitleCtrl.dispose();
    _companyCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickColor(Product product) async {
    final selectedIndex = _colorIndex ?? product.defaultColorIndex;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        padding: EdgeInsets.all(19.w),
        decoration: BoxDecoration(
          color: AppColors.cardColor.themeColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppText(
              LocaleKeys.store_card_color.tr(),
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
            16.height,
            ProductColorSwatches(
              product: product,
              selectedIndex: selectedIndex,
              onSelected: (index) {
                setState(() => _colorIndex = index);
                Navigator.pop(sheetContext);
              },
            ),
            16.height,
          ],
        ),
      ),
    );
  }

  Future<void> _chooseFont() async {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        padding: EdgeInsets.all(19.w),
        decoration: BoxDecoration(
          color: AppColors.cardColor.themeColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppText(
              LocaleKeys.store_choose_font.tr(),
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
            16.height,
            FontOptionChips(
              selected: _font,
              onSelected: (font) {
                setState(() => _font = font);
                Navigator.pop(sheetContext);
              },
            ),
            16.height,
          ],
        ),
      ),
    );
  }

  void _uploadLogo() =>
      AppOverlay.showSuccess(LocaleKeys.common_comingSoon.tr());

  void _addToCart(Product product) {
    final summary = [
      _jobTitleCtrl.text.trim(),
      _companyCtrl.text.trim(),
    ].where((value) => value.isNotEmpty).join(' · ');

    AppOverlay.showSuccess(LocaleKeys.store_added_to_cart.tr());
    NavigationService.goBack();
    if (summary.isNotEmpty) return;
  }

  @override
  Widget build(BuildContext context) {
    final product = StoreCatalog.productById(widget.productId);

    if (product == null) {
      return Scaffold(
        body: Column(
          children: [
            ScreenHeaderBar(
              title: LocaleKeys.store_customization_title.tr(),
            ),
            const Expanded(child: SizedBox.shrink()),
          ],
        ),
      );
    }

    final colorIndex = _colorIndex ?? product.defaultColorIndex;
    final colorLabel = product.colorLabelAt(colorIndex);
    final currency = LocaleKeys.store_currency.tr();

    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(
            title: LocaleKeys.store_customization_title.tr(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: 19.paddingHorizontal + 16.paddingVert,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.mintSoft.themeColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: AppText(
                        LocaleKeys.store_live_preview.tr(),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.mint.themeColor,
                      ),
                    ),
                  ),
                  12.height,
                  CardDesignPreview(
                    name: _nameCtrl.text,
                    jobTitle: _jobTitleCtrl.text,
                    company: _companyCtrl.text,
                    color: product.colorAt(colorIndex),
                    fontFamily: _font.family,
                  ),
                  16.height,
                  StoreSectionCard(
                    title: LocaleKeys.store_card_text.tr(),
                    child: Column(
                          children: [
                            CustomTextField(
                              hint: LocaleKeys.store_full_name.tr(),
                              controller: _nameCtrl,
                              onChanged: (_) => setState(() {}),
                            ),
                            10.height,
                            CustomTextField(
                              hint: LocaleKeys.store_job_title.tr(),
                              controller: _jobTitleCtrl,
                              onChanged: (_) => setState(() {}),
                            ),
                            10.height,
                            CustomTextField(
                              hint: LocaleKeys.store_company_name.tr(),
                              controller: _companyCtrl,
                              onChanged: (_) => setState(() {}),
                            ),
                            10.height,
                            CustomTextField(
                              hint: LocaleKeys.store_notes.tr(),
                              controller: _notesCtrl,
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                      12.height,
                      StoreSectionCard(
                        title: LocaleKeys.store_font_type.tr(),
                        child: FontOptionChips(
                          selected: _font,
                          onSelected: (font) => setState(() => _font = font),
                        ),
                      ),
                      12.height,
                      StoreSectionCard(
                        title: LocaleKeys.store_card_tools.tr(),
                        child: Column(
                          children: [
                            if (product.hasColors) ...[
                              CustomizationToolTile(
                                icon: Icons.palette_outlined,
                                title: LocaleKeys.store_card_color.tr(),
                                value:
                                    colorLabel.isEmpty ? null : colorLabel.tr(),
                                onTap: () => _pickColor(product),
                              ),
                              6.height,
                            ],
                            CustomizationToolTile(
                              icon: Icons.upload_file_outlined,
                              title: LocaleKeys.store_upload_logo.tr(),
                              onTap: _uploadLogo,
                            ),
                            6.height,
                            CustomizationToolTile(
                              icon: Icons.font_download_outlined,
                              title: LocaleKeys.store_choose_font.tr(),
                              value: _font.labelKey.tr(),
                              onTap: _chooseFont,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: StoreActionBar(
            title: LocaleKeys.store_approve_design.tr(
              namedArgs: {
                'price':
                    '${ConvertHelper.formatPrice(product.totalFor(1))} $currency',
              },
            ),
            onTap: () => _addToCart(product),
          ),
        );
  }
}
