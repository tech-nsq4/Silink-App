import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_overlay.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/flow_top_bar.dart';
import '../../../../core/widgets/gradient_action_button.dart';
import '../../../../core/widgets/photo_source_sheet.dart';
import '../../../profile_completion/data/models/catalog_model.dart';
import '../../company_profile_completion/presentation/widgets/workspace/workspace_field.dart';
import '../../company_profile_completion/presentation/widgets/workspace/workspace_field_label.dart';
import '../data/catalog_item_draft.dart';
import '../logic/company_catalog_cubit.dart';
import '../widgets/catalog_hub_image_picker.dart';
import '../widgets/catalog_hub_kind_tabs.dart';
import '../widgets/catalog_hub_option_chips.dart';
import '../widgets/catalog_hub_preview_card.dart';

class CatalogItemFormScreen extends StatefulWidget {
  const CatalogItemFormScreen({
    super.key,
    required this.kind,
    required this.actionTypes,
    this.item,
    this.section = '',
    this.sectionOptions = const [],
  });

  final String kind;
  final List<CatalogActionType> actionTypes;
  final CatalogItemModel? item;
  final String section;
  final List<String> sectionOptions;

  @override
  State<CatalogItemFormScreen> createState() => _CatalogItemFormScreenState();
}

class _CatalogItemFormScreenState extends State<CatalogItemFormScreen> {
  late String _kind = widget.item?.kind ?? widget.kind;
  late String _actionType = widget.item?.actionType.isNotEmpty == true
      ? widget.item!.actionType
      : (widget.actionTypes.length > 1
          ? widget.actionTypes[1].type
          : widget.actionTypes.firstOrNull?.type ?? 'inquire');
  late final _sectionCtrl = TextEditingController(text: widget.section);
  late final _nameCtrl = TextEditingController(text: widget.item?.name);
  late final _descriptionCtrl =
      TextEditingController(text: widget.item?.description);
  late final _priceCtrl = TextEditingController(text: widget.item?.price);
  late final _priceLabelCtrl =
      TextEditingController(text: widget.item?.priceLabel);
  late final _actionUrlCtrl =
      TextEditingController(text: widget.item?.actionUrl);
  File? _image;

  bool get _isEdit => widget.item != null;
  bool get _isOffer => _kind == CompanyCatalogCubit.offerKind;

  List<String> get _sections => {
        LocaleKeys.catalogHub_sectionDrinks.tr(),
        LocaleKeys.catalogHub_sectionMain.tr(),
        LocaleKeys.catalogHub_sectionStarters.tr(),
        ...widget.sectionOptions,
      }.toList();

  @override
  void dispose() {
    for (final controller in [
      _sectionCtrl,
      _nameCtrl,
      _descriptionCtrl,
      _priceCtrl,
      _priceLabelCtrl,
      _actionUrlCtrl,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  String get _actionLabel =>
      widget.actionTypes
          .where((type) => type.type == _actionType)
          .firstOrNull
          ?.label ??
      '';

  String get _priceLine {
    final price = _priceCtrl.text.trim();
    final label = _priceLabelCtrl.text.trim();
    if (price.isEmpty) return label;
    return [
      if (label.isNotEmpty) label,
      '$price ${LocaleKeys.store_currency.tr()}'
    ].join(' ');
  }

  Future<void> _pickImage() async {
    final source = await PhotoSourceSheet.show(context);
    if (source == null || !mounted) return;
    try {
      final picked = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1200,
        imageQuality: 85,
      );
      if (picked == null || !mounted) return;
      setState(() => _image = File(picked.path));
    } catch (_) {
      AppOverlay.showError(
        LocaleKeys.profile_type_basic_info_photo_pick_error.tr(),
      );
    }
  }

  void _save() {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) {
      AppOverlay.showError(LocaleKeys.catalogHub_nameRequired.tr());
      return;
    }
    Navigator.of(context).pop(CatalogItemDraft(
      kind: _kind,
      name: name,
      description: _descriptionCtrl.text.trim(),
      price: _priceCtrl.text.trim(),
      priceLabel: _priceLabelCtrl.text.trim(),
      actionType: _actionType,
      actionUrl: _actionUrlCtrl.text.trim(),
      section: _isOffer ? '' : _sectionCtrl.text.trim(),
      image: _image,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final kinds = [CompanyCatalogCubit.itemKind, CompanyCatalogCubit.offerKind];
    return Scaffold(
      backgroundColor: AppColors.backgroundColor.themeColor,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: FlowTopBar(
              title: _isEdit
                  ? LocaleKeys.catalogHub_formEdit.tr()
                  : LocaleKeys.catalogHub_formAdd.tr(),
            ),
          ),
          Expanded(
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.fromLTRB(22.w, 8.h, 22.w, 24.h),
              children: [
                CatalogHubKindTabs(
                  labels: [
                    LocaleKeys.catalogHub_kindItem.tr(),
                    LocaleKeys.catalogHub_kindOffer.tr(),
                  ],
                  selected: kinds.indexOf(_kind),
                  enabled: !_isEdit,
                  onSelected: (index) => setState(() => _kind = kinds[index]),
                ),
                if (!_isOffer) ...[
                  // WorkspaceFieldLabel(text: LocaleKeys.catalogHub_section.tr()),
                  // CatalogHubOptionChips(
                  //   options: _sections,
                  //   labelOf: (section) => section,
                  //   selected: _sectionCtrl.text.trim(),
                  //   onSelected: (section) =>
                  //       setState(() => _sectionCtrl.text = section),
                  // ),
                  // SizedBox(height: 10.h),
                  WorkspaceField(
                    label: LocaleKeys.catalogHub_section.tr(),
                    hint: LocaleKeys.catalogHub_sectionHint.tr(),
                    controller: _sectionCtrl,
                    onChanged: (_) => setState(() {}),
                  ),
                ],
                WorkspaceField(
                  label: LocaleKeys.catalogHub_name.tr(),
                  hint: LocaleKeys.catalogHub_nameHint.tr(),
                  controller: _nameCtrl,
                  required: true,
                  onChanged: (_) => setState(() {}),
                ),
                WorkspaceField(
                  label: LocaleKeys.catalogHub_description.tr(),
                  hint: LocaleKeys.catalogHub_descriptionHint.tr(),
                  controller: _descriptionCtrl,
                  maxLines: 3,
                ),
                WorkspaceFieldLabel(text: LocaleKeys.catalogHub_image.tr()),
                CatalogHubImagePicker(
                  label:
                      _image != null || (widget.item?.imageUrl ?? '').isNotEmpty
                          ? LocaleKeys.catalogHub_changeImage.tr()
                          : LocaleKeys.catalogHub_upload.tr(),
                  file: _image,
                  url: widget.item?.imageUrl,
                  onTap: _pickImage,
                ),
                SizedBox(height: 18.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: WorkspaceField(
                        label: LocaleKeys.catalogHub_price.tr(),
                        hint: '500',
                        controller: _priceCtrl,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    12.width,
                    Expanded(
                      child: WorkspaceField(
                        label: LocaleKeys.catalogHub_priceLabel.tr(),
                        hint: LocaleKeys.catalogHub_priceLabelHint.tr(),
                        controller: _priceLabelCtrl,
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                  ],
                ),
                if (widget.actionTypes.isNotEmpty) ...[
                  WorkspaceFieldLabel(text: LocaleKeys.catalogHub_action.tr()),
                  CatalogHubOptionChips(
                    options: [for (final type in widget.actionTypes) type.type],
                    labelOf: (type) => widget.actionTypes
                        .firstWhere((option) => option.type == type)
                        .label,
                    selected: _actionType,
                    onSelected: (type) => setState(() => _actionType = type),
                  ),
                  SizedBox(height: 18.h),
                ],
                WorkspaceField(
                  label: LocaleKeys.catalogHub_actionUrl.tr(),
                  hint: 'https://...',
                  controller: _actionUrlCtrl,
                  keyboardType: TextInputType.url,
                ),
                WorkspaceFieldLabel(text: LocaleKeys.catalogHub_preview.tr()),
                CatalogHubPreviewCard(
                  name: _nameCtrl.text,
                  badge: _isOffer
                      ? LocaleKeys.catalogHub_kindOffer.tr()
                      : (_sectionCtrl.text.trim().isEmpty
                          ? LocaleKeys.catalogHub_kindItem.tr()
                          : _sectionCtrl.text.trim()),
                  priceLine: _priceLine,
                  actionLabel: _actionLabel,
                  file: _image,
                  url: widget.item?.imageUrl,
                  isOffer: _isOffer,
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
                title: LocaleKeys.catalogHub_save.tr(),
                centerTitle: true,
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
