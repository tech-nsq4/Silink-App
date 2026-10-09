import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/router/navigation_services.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/convert_helper.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/flow_top_bar.dart';
import '../../../core/widgets/gradient_action_button.dart';
import '../../cart/data/models/cart_item.dart';
import '../../cart/logic/cart_cubit.dart';
import '../data/models/print_palette.dart';
import '../data/models/product.dart';
import '../widgets/shop_card_mockup.dart';
import '../widgets/shop_color_picker.dart';
import '../widgets/shop_face_toggle.dart';
import '../widgets/shop_field.dart';
import '../widgets/shop_logo_upload.dart';
import '../widgets/shop_section_label.dart';
import '../widgets/shop_toggle_tile.dart';

class CardCustomizationScreen extends StatefulWidget {
  const CardCustomizationScreen({super.key, required this.product});

  final Product product;

  @override
  State<CardCustomizationScreen> createState() =>
      _CardCustomizationScreenState();
}

class _CardCustomizationScreenState extends State<CardCustomizationScreen> {
  late final _nameCtrl = TextEditingController(text: kUserModel?.fullName);
  late final _jobTitleCtrl =
      TextEditingController(text: kUserModel?.jobTitle ?? '');
  late final _companyCtrl =
      TextEditingController(text: kUserModel?.company ?? '');
  final _notesCtrl = TextEditingController();

  bool _showBack = false;
  bool _doubleSided = false;
  int _cardColor = 0;
  int _printColor = 0;
  File? _logo;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _jobTitleCtrl.dispose();
    _companyCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  double get _unitPrice =>
      widget.product.price +
      (_doubleSided ? AppConstants.doubleSidedPrintCost : 0);

  String _valueOr(TextEditingController controller, String fallback) {
    final value = controller.text.trim();
    return value.isEmpty ? fallback : value;
  }

  Future<void> _pickLogo() async {
    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1600,
      );
      if (picked == null || !mounted) return;
      if (await picked.length() > AppConstants.maxLogoBytes) {
        AppOverlay.showError(LocaleKeys.shop_logoTooBig.tr());
        return;
      }
      setState(() => _logo = File(picked.path));
    } catch (_) {
      AppOverlay.showError(
        LocaleKeys.profile_type_basic_info_photo_pick_error.tr(),
      );
    }
  }

  void _save() {
    final summary = [
      _nameCtrl.text.trim(),
      _jobTitleCtrl.text.trim(),
      _companyCtrl.text.trim(),
      if (_doubleSided) LocaleKeys.shop_doubleTitle.tr(),
      _notesCtrl.text.trim(),
    ].where((value) => value.isNotEmpty).join(' · ');
    context.read<CartCubit>().addItem(
          CartItem(
            productId: widget.product.id,
            name: widget.product.name,
            image: widget.product.image,
            price: _unitPrice,
            colorValue: PrintPalette.cardColors[_cardColor].toARGB32(),
            summary: summary,
            imageGradientValues: widget.product.imageGradientValues,
          ),
        );
    AppOverlay.showSuccess(LocaleKeys.store_added_to_cart.tr());
    NavigationService.goBack();
  }

  @override
  Widget build(BuildContext context) {
    final currency = LocaleKeys.store_currency.tr();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor.themeColor,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: FlowTopBar(title: LocaleKeys.shop_customTitle.tr()),
          ),
          Expanded(
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.fromLTRB(22.w, 6.h, 22.w, 24.h),
              children: [
                ShopFaceToggle(
                  labels: [
                    LocaleKeys.shop_front.tr(),
                    LocaleKeys.shop_back.tr(),
                  ],
                  selected: _showBack ? 1 : 0,
                  onSelected: (index) => setState(() => _showBack = index == 1),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: ShopCardMockup(
                    showBack: _showBack,
                    cardColor: PrintPalette.cardColors[_cardColor],
                    printColor: PrintPalette.printColors[_printColor],
                    name: _valueOr(
                        _nameCtrl, LocaleKeys.shop_namePlaceholder.tr()),
                    jobTitle:
                        _valueOr(_jobTitleCtrl, LocaleKeys.shop_jobTitle.tr()),
                    company:
                        _valueOr(_companyCtrl, LocaleKeys.shop_company.tr()),
                    logo: _logo,
                  ),
                ),
                SizedBox(height: 22.h),
                ShopField(
                  label: LocaleKeys.shop_fullName.tr(),
                  hint: LocaleKeys.shop_namePlaceholder.tr(),
                  controller: _nameCtrl,
                  onChanged: (_) => setState(() {}),
                ),
                ShopField(
                  label: LocaleKeys.shop_jobTitle.tr(),
                  hint: LocaleKeys.shop_jobTitle.tr(),
                  controller: _jobTitleCtrl,
                  onChanged: (_) => setState(() {}),
                ),
                ShopField(
                  label: LocaleKeys.shop_company.tr(),
                  hint: LocaleKeys.shop_company.tr(),
                  controller: _companyCtrl,
                  onChanged: (_) => setState(() {}),
                ),
                ShopSectionLabel(text: LocaleKeys.shop_logoLabel.tr()),
                ShopLogoUpload(
                  logo: _logo,
                  onPick: _pickLogo,
                  onRemove: () => setState(() => _logo = null),
                ),
                SizedBox(height: 18.h),
                ShopSectionLabel(text: LocaleKeys.shop_cardColor.tr()),
                ShopColorPicker(
                  colors: PrintPalette.cardColors,
                  selected: _cardColor,
                  size: 30.w,
                  spacing: 4.w,
                  onSelected: (index) => setState(() => _cardColor = index),
                ),
                SizedBox(height: 16.h),
                ShopSectionLabel(text: LocaleKeys.shop_printColor.tr()),
                ShopColorPicker(
                  colors: PrintPalette.printColors,
                  selected: _printColor,
                  size: 30.w,
                  spacing: 4.w,
                  onSelected: (index) => setState(() => _printColor = index),
                ),
                SizedBox(height: 18.h),
                ShopToggleTile(
                  title: LocaleKeys.shop_doubleTitle.tr(),
                  subtitle: LocaleKeys.shop_doubleSubtitle.tr(),
                  value: _doubleSided,
                  onChanged: (value) => setState(() => _doubleSided = value),
                ),
                SizedBox(height: 18.h),
                ShopField(
                  label: LocaleKeys.shop_notesLabel.tr(),
                  hint: LocaleKeys.shop_notesHint.tr(),
                  controller: _notesCtrl,
                  maxLines: 4,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(22.w, 12.h, 22.w, 12.h),
            decoration: BoxDecoration(
              color: AppColors.white.themeColor,
              border: Border(
                top: BorderSide(color: AppColors.studioStepLine.themeColor),
              ),
            ),
            child: SafeArea(
              top: false,
              child: GradientActionButton(
                title: LocaleKeys.shop_save.tr(),
                trailing: '${ConvertHelper.formatPrice(_unitPrice)} $currency',
                radius: 14,
                minHeight: 50,
                onTap: _save,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
