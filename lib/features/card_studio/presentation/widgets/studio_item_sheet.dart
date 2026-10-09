import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_overlay.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/image/custom_image.dart';
import '../../../../core/widgets/photo_source_sheet.dart';
import '../../data/models/studio_item.dart';
import 'studio_field.dart';
import 'studio_segmented_tabs.dart';
import 'studio_select_field.dart';
import 'studio_toggle.dart';

class StudioItemSheet extends StatefulWidget {
  const StudioItemSheet({super.key, this.item});

  final StudioItem? item;

  static Future<StudioItem?> show(BuildContext context, {StudioItem? item}) =>
      showModalBottomSheet<StudioItem>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: AppColors.profileHero.themeColor.withValues(alpha: 0.53),
        builder: (_) => StudioItemSheet(item: item),
      );

  @override
  State<StudioItemSheet> createState() => _StudioItemSheetState();
}

class _StudioItemSheetState extends State<StudioItemSheet> {
  late String _kind = widget.item?.kind ?? 'service';
  late String _actionType =
      widget.item?.actionType ?? StudioItem.defaultActionType;
  late bool _visible = widget.item?.visible ?? true;
  File? _image;
  late final _nameCtrl = TextEditingController(text: widget.item?.name ?? '');
  late final _descriptionCtrl =
      TextEditingController(text: widget.item?.description ?? '');
  late final _priceCtrl = TextEditingController(text: widget.item?.price ?? '');
  late final _priceLabelCtrl =
      TextEditingController(text: widget.item?.priceLabel ?? '');
  late final _actionUrlCtrl =
      TextEditingController(text: widget.item?.actionUrl ?? '');

  bool get _isEdit => widget.item != null;
  bool get _canSave => _nameCtrl.text.trim().isNotEmpty;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descriptionCtrl.dispose();
    _priceCtrl.dispose();
    _priceLabelCtrl.dispose();
    _actionUrlCtrl.dispose();
    super.dispose();
  }

  String _actionLabel(String type) => switch (type) {
        'order' => LocaleKeys.cardStudio_actionOrder.tr(),
        'book' => LocaleKeys.cardStudio_actionBook.tr(),
        'whatsapp' => LocaleKeys.cardStudio_actionWhatsapp.tr(),
        'link' => LocaleKeys.cardStudio_actionLink.tr(),
        _ => LocaleKeys.cardStudio_actionInquire.tr(),
      };

  Future<void> _pickImage() async {
    final source = await PhotoSourceSheet.show(context);
    if (source == null || !mounted) return;
    try {
      final picked = await ImagePicker()
          .pickImage(source: source, maxWidth: 1024, imageQuality: 85);
      if (picked == null || !mounted) return;
      setState(() => _image = File(picked.path));
    } catch (_) {
      if (mounted) {
        AppOverlay.showError(LocaleKeys.common_somethingWentWrong.tr());
      }
    }
  }

  void _save() {
    if (!_canSave) return;
    final base = widget.item ??
        StudioItem(
          localId: DateTime.now().microsecondsSinceEpoch.toString(),
          kind: _kind,
          name: '',
        );
    Navigator.pop(
      context,
      base.copyWith(
        kind: _kind,
        name: _nameCtrl.text.trim(),
        description: _descriptionCtrl.text.trim(),
        price: _priceCtrl.text.trim(),
        priceLabel: _priceLabelCtrl.text.trim(),
        actionType: _actionType,
        actionUrl: _actionUrlCtrl.text.trim(),
        imageFile: _image,
        visible: _visible,
      ),
    );
  }

  Widget _imagePreview() {
    final url = widget.item?.imageUrl?.trim() ?? '';
    final file = _image ?? widget.item?.imageFile;
    final hasImage = file != null || url.isNotEmpty;
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 92.h,
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.studioFieldFill.themeColor,
          borderRadius: BorderRadius.circular(11.r),
          border: Border.all(color: AppColors.studioFieldBorder.themeColor),
        ),
        child: hasImage
            ? Stack(
                fit: StackFit.expand,
                children: [
                  if (file != null)
                    Image.file(file, fit: BoxFit.cover)
                  else
                    CustomImage(image: url, fit: BoxFit.cover),
                  PositionedDirectional(
                    bottom: 8.h,
                    end: 8.w,
                    child:
                        _imageChip(LocaleKeys.cardStudio_itemChangeImage.tr()),
                  ),
                ],
              )
            : _imageChip(LocaleKeys.cardStudio_itemAddImage.tr()),
      ),
    );
  }

  Widget _imageChip(String label) {
    final accent = AppColors.accentTeal.themeColor;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(20.r),
        border:
            Border.all(color: AppColors.studioSummaryButtonBorder.themeColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.photo_camera_outlined, size: 14.sp, color: accent),
          6.width,
          AppText(label, fontSize: 10.sp, color: accent),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        constraints: BoxConstraints(maxHeight: 0.9.sh),
        decoration: BoxDecoration(
          color: AppColors.profileSurface.themeColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(23.r)),
        ),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.fromLTRB(
              22.w, 22.h, 22.w, 22.h + MediaQuery.paddingOf(context).bottom),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  _isEdit
                      ? LocaleKeys.cardStudio_itemSheetEdit.tr()
                      : LocaleKeys.cardStudio_itemSheetAdd.tr(),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  customBorder: const CircleBorder(),
                  child: Container(
                    padding: EdgeInsets.all(7.w),
                    decoration: BoxDecoration(
                      color: AppColors.white.themeColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: AppColors.assistantBackBorder.themeColor),
                    ),
                    child: Icon(Icons.close_rounded,
                        size: 16.sp,
                        color: AppColors.assistantSourceIcon.themeColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 18.h),
            StudioSegmentedTabs(
              labels: [
                LocaleKeys.cardStudio_kindService.tr(),
                LocaleKeys.cardStudio_kindProduct.tr(),
              ],
              selected: _kind == 'service' ? 0 : 1,
              onSelected: (index) =>
                  setState(() => _kind = index == 0 ? 'service' : 'product'),
            ),
            StudioField(
              label: LocaleKeys.cardStudio_itemName.tr(),
              hint: LocaleKeys.cardStudio_itemNameHint.tr(),
              controller: _nameCtrl,
              required: true,
              onChanged: (_) => setState(() {}),
            ),
            SizedBox(height: 17.h),
            StudioField(
              label: LocaleKeys.cardStudio_itemDescription.tr(),
              controller: _descriptionCtrl,
              maxLines: 3,
            ),
            SizedBox(height: 17.h),
            AppText(
              LocaleKeys.cardStudio_itemImage.tr(),
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.studioFieldLabel.themeColor,
            ),
            SizedBox(height: 7.h),
            _imagePreview(),
            SizedBox(height: 17.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: StudioField(
                    label: LocaleKeys.cardStudio_itemPrice.tr(),
                    controller: _priceCtrl,
                    keyboardType: TextInputType.number,
                  ),
                ),
                10.width,
                Expanded(
                  child: StudioField(
                    label: LocaleKeys.cardStudio_itemPriceLabel.tr(),
                    hint: LocaleKeys.cardStudio_itemPriceLabelHint.tr(),
                    controller: _priceLabelCtrl,
                  ),
                ),
              ],
            ),
            SizedBox(height: 17.h),
            StudioSelectField<String>(
              label: LocaleKeys.cardStudio_itemAction.tr(),
              labelColor: AppColors.studioFieldLabel.themeColor,
              value: _actionType,
              options: StudioItem.actionTypes,
              labelOf: _actionLabel,
              onChanged: (value) => setState(() => _actionType = value),
            ),
            SizedBox(height: 17.h),
            StudioField(
              label: LocaleKeys.cardStudio_itemActionValue.tr(),
              controller: _actionUrlCtrl,
              keyboardType: TextInputType.url,
              ltr: true,
            ),
            SizedBox(height: 17.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  LocaleKeys.cardStudio_itemVisible.tr(),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                ),
                StudioToggle(
                  value: _visible,
                  onChanged: (value) => setState(() => _visible = value),
                ),
              ],
            ),
            SizedBox(height: 22.h),
            Row(
              children: [
                Expanded(
                  child: _sheetButton(
                    label: _isEdit
                        ? LocaleKeys.cardStudio_itemSaveCta.tr()
                        : LocaleKeys.cardStudio_itemAddCta.tr(),
                    background: accent.withValues(alpha: _canSave ? 1 : 0.4),
                    foreground: AppColors.white.light,
                    onTap: _canSave ? _save : null,
                  ),
                ),
                8.width,
                Expanded(
                  child: _sheetButton(
                    label: LocaleKeys.common_cancel.tr(),
                    background: AppColors.studioTabs.themeColor,
                    foreground: AppColors.studioTabText.themeColor,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sheetButton({
    required String label,
    required Color background,
    required Color foreground,
    required VoidCallback? onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 13.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(9.r),
          ),
          child: AppText(
            label,
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
            color: foreground,
          ),
        ),
      );
}
