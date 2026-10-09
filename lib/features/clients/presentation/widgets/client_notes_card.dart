import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../data/models/client_extras.dart';
import 'client_add_link.dart';
import 'client_inline_actions.dart';
import 'client_section_card.dart';

class ClientNotesCard extends StatefulWidget {
  const ClientNotesCard({super.key, required this.notes, required this.onAdd});

  final List<ClientNote> notes;
  final ValueChanged<String> onAdd;

  @override
  State<ClientNotesCard> createState() => _ClientNotesCardState();
}

class _ClientNotesCardState extends State<ClientNotesCard> {
  final _textCtrl = TextEditingController();
  bool _editing = false;

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  void _add() {
    final text = _textCtrl.text.trim();
    if (text.isEmpty) return;
    widget.onAdd(text);
    _textCtrl.clear();
    setState(() => _editing = false);
  }

  @override
  Widget build(BuildContext context) {
    final secondary = AppColors.textSecondaryColor.themeColor;
    final locale = context.locale.toString();
    return ClientSectionCard(
      title: LocaleKeys.clientsHub_notes.tr(args: ['${widget.notes.length}']),
      trailing: _editing
          ? null
          : ClientAddLink(onTap: () => setState(() => _editing = true)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_editing) ...[
            CustomTextField(
              controller: _textCtrl,
              hint: LocaleKeys.clientsHub_noteHint.tr(),
              maxLines: 4,
              borderRadius: 14.r,
              fillColor: AppColors.white.themeColor,
              borderColor: AppColors.accentTeal.themeColor,
              focusedBorderColor: AppColors.accentTeal.themeColor,
            ),
            SizedBox(height: 14.h),
            ClientInlineActions(
              saveLabel: LocaleKeys.clientsHub_addNote.tr(),
              onSave: _add,
              onCancel: () => setState(() => _editing = false),
            ),
            if (widget.notes.isNotEmpty) SizedBox(height: 14.h),
          ],
          if (widget.notes.isEmpty && !_editing)
            AppText(LocaleKeys.clientsHub_noNotes.tr(),
                fontSize: 9.5.sp, color: secondary),
          for (final note in widget.notes)
            Container(
              margin: EdgeInsets.only(bottom: 8.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.studioSelectFill.themeColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(note.text, fontSize: 10.sp, height: 1.6),
                  SizedBox(height: 6.h),
                  AppText(
                    DateFormat.yMMMd(locale).add_jm().format(note.createdAt),
                    fontSize: 7.5.sp,
                    color: secondary,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
