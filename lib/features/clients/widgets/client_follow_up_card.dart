import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'client_details_models.dart';
import 'deletable_tile.dart';
import 'picker_field.dart';
import 'section_card.dart';

class ClientFollowUpCard extends StatelessWidget {
  const ClientFollowUpCard({
    super.key,
    required this.followUp,
    required this.isAdding,
    required this.onToggleAdding,
    required this.date,
    required this.time,
    required this.reasonController,
    required this.onPickDate,
    required this.onPickTime,
    required this.onSave,
    required this.onCancel,
    required this.onDelete,
  });

  final FollowUpData? followUp;
  final bool isAdding;
  final VoidCallback onToggleAdding;
  final DateTime? date;
  final TimeOfDay? time;
  final TextEditingController reasonController;
  final VoidCallback onPickDate;
  final VoidCallback onPickTime;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: LocaleKeys.clients_followUp.tr(),
      trailing: AddButton(
        label: LocaleKeys.clients_add.tr(),
        onTap: onToggleAdding,
      ),
      children: [
        if (followUp != null) ...[
          DeletableTile(
            title: [
              formatDate(followUp!.date),
              if (followUp!.time != null) formatTime(context, followUp!.time!),
            ].join(' • '),
            subtitle: followUp!.reason,
            onDelete: onDelete,
          ),
          12.height,
        ] else if (!isAdding)
          EmptyPlaceholder(text: LocaleKeys.clients_noFollowUp.tr()),
        if (isAdding) ...[
          Row(
            children: [
              Expanded(
                child: PickerField(
                  text: date == null
                      ? LocaleKeys.clients_followUpDateHint.tr()
                      : formatDate(date!),
                  icon: Icons.calendar_today_rounded,
                  isPlaceholder: date == null,
                  onTap: onPickDate,
                ),
              ),
              10.width,
              Expanded(
                child: PickerField(
                  text: time == null
                      ? LocaleKeys.clients_followUpTimeHint.tr()
                      : formatTime(context, time!),
                  icon: Icons.access_time_rounded,
                  isPlaceholder: time == null,
                  onTap: onPickTime,
                ),
              ),
            ],
          ),
          10.height,
          CustomTextField(
            controller: reasonController,
            hint: LocaleKeys.clients_followUpReasonHint.tr(),
            fillColor: AppColors.white.themeColor,
          ),
          14.height,
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onTap: onSave,
                  title: LocaleKeys.clients_save.tr(),
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
