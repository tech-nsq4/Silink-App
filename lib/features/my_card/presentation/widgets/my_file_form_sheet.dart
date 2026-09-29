import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_overlay.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/field_label.dart';
import '../../../../core/widgets/photo_source_sheet.dart';
import '../../data/models/file_category_model.dart';
import '../../data/models/my_file_model.dart';
import '../../logic/my_file_cubit.dart';
import 'my_file_category_chips.dart';
import 'my_file_image_field.dart';

class MyFileFormSheet extends StatefulWidget {
  const MyFileFormSheet({
    super.key,
    required this.categories,
    this.initial,
  });

  final List<FileCategoryModel> categories;
  final MyFileModel? initial;

  static Future<bool> show(
    BuildContext context, {
    required List<FileCategoryModel> categories,
    MyFileModel? initial,
  }) async {
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => MyFileFormSheet(categories: categories, initial: initial),
    );
    return saved == true;
  }

  @override
  State<MyFileFormSheet> createState() => _MyFileFormSheetState();
}

class _MyFileFormSheetState extends State<MyFileFormSheet> {
  late final MyFileCubit _cubit = getIt<MyFileCubit>();
  late final TextEditingController _nameCtrl =
      TextEditingController(text: widget.initial?.name ?? '');
  late final TextEditingController _noteCtrl =
      TextEditingController(text: widget.initial?.note ?? '');
  late final Set<String> _selectedIds = {...?widget.initial?.categoryIds};
  File? _image;

  bool get _isEdit => widget.initial != null;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _noteCtrl.dispose();
    _cubit.close();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final source = await PhotoSourceSheet.show(context);
    if (source == null || !mounted) return;
    try {
      final picked = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1600,
        imageQuality: 85,
      );
      if (picked == null || !mounted) return;
      setState(() => _image = File(picked.path));
    } catch (_) {
      if (!mounted) return;
      AppOverlay.showError(LocaleKeys.common_somethingWentWrong.tr());
    }
  }

  void _toggleCategory(String id) {
    setState(() {
      if (!_selectedIds.remove(id)) _selectedIds.add(id);
    });
  }

  void _submit() {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) {
      AppOverlay.showError(LocaleKeys.myFiles_nameRequired.tr());
      return;
    }
    final categoryIds = _selectedIds.toList();
    final note = _noteCtrl.text.trim();
    final initial = widget.initial;
    if (initial != null) {
      _cubit.updateFile(
        id: initial.id,
        name: name,
        note: note,
        categoryIds: categoryIds,
        file: _image,
      );
      return;
    }
    final image = _image;
    if (image == null) {
      AppOverlay.showError(LocaleKeys.myFiles_imageRequired.tr());
      return;
    }
    _cubit.createFile(
      name: name,
      note: note,
      categoryIds: categoryIds,
      file: image,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        constraints: BoxConstraints(maxHeight: 0.9.sh),
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(19.w, 20.h, 19.w, 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  _isEdit
                      ? LocaleKeys.myFiles_editTitle.tr()
                      : LocaleKeys.myFiles_addTitle.tr(),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
                16.height,
                FieldLabel(
                  text: LocaleKeys.myFiles_imageLabel.tr(),
                  required: !_isEdit,
                ),
                MyFileImageField(
                  initials: widget.initial?.initials ?? '',
                  localFile: _image,
                  imageUrl: widget.initial?.fileUrl,
                  onPick: _pickImage,
                ),
                12.height,
                FieldLabel(
                  text: LocaleKeys.myFiles_nameLabel.tr(),
                  required: true,
                ),
                CustomTextField(
                  controller: _nameCtrl,
                  hint: LocaleKeys.myFiles_nameHint.tr(),
                ),
                12.height,
                FieldLabel(text: LocaleKeys.myFiles_noteLabel.tr()),
                CustomTextField(
                  controller: _noteCtrl,
                  hint: LocaleKeys.myFiles_noteHint.tr(),
                  maxLines: 3,
                ),
                if (widget.categories.isNotEmpty) ...[
                  12.height,
                  FieldLabel(text: LocaleKeys.myFiles_categoriesLabel.tr()),
                  4.height,
                  MyFileCategoryChips(
                    categories: widget.categories,
                    selectedIds: _selectedIds,
                    onToggle: _toggleCategory,
                  ),
                ],
                24.height,
                BlocConsumer<MyFileCubit, MyFileState>(
                  bloc: _cubit,
                  listener: (context, state) {
                    if (state is MyFileSaved) Navigator.of(context).pop(true);
                  },
                  builder: (context, state) => CustomButton(
                    title: LocaleKeys.myFiles_save.tr(),
                    loading: state is MyFileSubmitting,
                    onTap: _submit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
