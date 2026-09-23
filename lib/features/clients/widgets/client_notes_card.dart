import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'client_details_models.dart';
import 'deletable_tile.dart';
import 'section_card.dart';

class ClientNotesCard extends StatelessWidget {
  const ClientNotesCard({
    super.key,
    required this.notes,
    required this.isAdding,
    required this.onToggleAdding,
    required this.controller,
    required this.onAdd,
    required this.onCancel,
    required this.onDelete,
  });

  final List<ClientNote> notes;
  final bool isAdding;
  final VoidCallback onToggleAdding;
  final TextEditingController controller;
  final VoidCallback onAdd;
  final VoidCallback onCancel;
  final ValueChanged<int> onDelete;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: LocaleKeys.clients_notesCount.tr(args: ['${notes.length}']),
      trailing: AddButton(
        label: LocaleKeys.clients_add.tr(),
        onTap: onToggleAdding,
      ),
      children: [
        if (notes.isEmpty && !isAdding)
          EmptyPlaceholder(text: LocaleKeys.clients_noNotes.tr())
        else
          for (var i = 0; i < notes.length; i++) ...[
            if (i > 0) 8.height,
            DeletableTile(
              title: notes[i].text,
              titleWeight: FontWeight.w600,
              subtitle:
                  '${formatDate(notes[i].createdAt)} • ${formatTime(context, TimeOfDay.fromDateTime(notes[i].createdAt))}',
              onDelete: () => onDelete(i),
            ),
          ],
        if (isAdding) ...[
          6.height,
          CustomTextField(
            controller: controller,
            hint: LocaleKeys.clients_noteHint.tr(),
            maxLines: 3,
            borderColor: AppColors.borderColor.themeColor,
            fillColor: AppColors.white.themeColor,
          ),
          14.height,
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onTap: onAdd,
                  title: LocaleKeys.clients_addNoteAction.tr(),
                  height: 42,
                  radius: 12,
                  fontSize: 13,
                ),
              ),
              12.width,
              Expanded(
                child: CustomButton(
                  onTap: onCancel,
                  title: LocaleKeys.common_cancel.tr(),
                  height: 42,
                  radius: 12,
                  fontSize: 13,
                  isOutlined: true,
                  color: AppColors.white.themeColor,
                  borderColor: AppColors.borderColor.themeColor,
                  textColor: AppColors.textPrimaryColor.themeColor,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
