import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_overlay.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/custom_tap_effect.dart';
import '../../data/models/client_extras.dart';
import 'client_add_link.dart';
import 'client_inline_actions.dart';
import 'client_section_card.dart';

class ClientFollowUpCard extends StatefulWidget {
  const ClientFollowUpCard({
    super.key,
    required this.followUp,
    required this.onSave,
  });

  final ClientFollowUp? followUp;
  final ValueChanged<ClientFollowUp?> onSave;

  @override
  State<ClientFollowUpCard> createState() => _ClientFollowUpCardState();
}

class _ClientFollowUpCardState extends State<ClientFollowUpCard> {
  final _textCtrl = TextEditingController();
  bool _editing = false;
  DateTime? _date;
  TimeOfDay? _time;

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  void _startEditing() {
    final current = widget.followUp;
    setState(() {
      _editing = true;
      _date = current?.at;
      _time = current == null ? null : TimeOfDay.fromDateTime(current.at);
      _textCtrl.text = current?.text ?? '';
    });
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? now,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: now.add(const Duration(days: 365 * 3)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _time ?? TimeOfDay.now(),
    );
    if (picked != null) setState(() => _time = picked);
  }

  void _save() {
    final date = _date;
    final time = _time;
    if (date == null || time == null) {
      AppOverlay.showError(LocaleKeys.clientsHub_followUpRequired.tr());
      return;
    }
    widget.onSave(ClientFollowUp(
      at: DateTime(date.year, date.month, date.day, time.hour, time.minute),
      text: _textCtrl.text.trim(),
    ));
    setState(() => _editing = false);
  }

  Widget _pickerBox(String value, IconData icon, VoidCallback onTap) =>
      Expanded(
        child: CustomTapEffect(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
            decoration: BoxDecoration(
              color: AppColors.white.themeColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.studioPanelBorder.themeColor),
            ),
            child: Row(
              children: [
                Expanded(
                  child: AppText(value, fontSize: 10.sp, maxLines: 1),
                ),
                Icon(icon,
                    size: 16.sp,
                    color: AppColors.textSecondaryColor.themeColor),
              ],
            ),
          ),
        ),
      );

  Widget _editor(BuildContext context) {
    final locale = context.locale.toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            _pickerBox(
              _date == null
                  ? LocaleKeys.clientsHub_pickDate.tr()
                  : DateFormat.yMd(locale).format(_date!),
              Icons.calendar_today_outlined,
              _pickDate,
            ),
            10.width,
            _pickerBox(
              _time?.format(context) ?? LocaleKeys.clientsHub_pickTime.tr(),
              Icons.schedule_rounded,
              _pickTime,
            ),
          ],
        ),
        SizedBox(height: 10.h),
        CustomTextField(
          controller: _textCtrl,
          hint: LocaleKeys.clientsHub_followUpHint.tr(),
          borderRadius: 12.r,
          fillColor: AppColors.white.themeColor,
          borderColor: AppColors.studioPanelBorder.themeColor,
          focusedBorderColor: AppColors.accentTeal.themeColor,
        ),
        SizedBox(height: 14.h),
        ClientInlineActions(
          saveLabel: LocaleKeys.clientsHub_save.tr(),
          onSave: _save,
          onCancel: () => setState(() => _editing = false),
        ),
      ],
    );
  }

  Widget _summary(BuildContext context, ClientFollowUp followUp) {
    final locale = context.locale.toString();
    final accent = AppColors.accentTeal.themeColor;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.event_available_outlined, size: 18.sp, color: accent),
        10.width,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                DateFormat.yMMMEd(locale).add_jm().format(followUp.at),
                fontSize: 10.5.sp,
                fontWeight: FontWeight.w800,
              ),
              if (followUp.text.isNotEmpty) ...[
                SizedBox(height: 4.h),
                AppText(
                  followUp.text,
                  fontSize: 9.5.sp,
                  color: AppColors.textSecondaryColor.themeColor,
                ),
              ],
            ],
          ),
        ),
        ClientAddLink(
          label: LocaleKeys.clientsHub_removeFollowUp.tr(),
          onTap: () => widget.onSave(null),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final followUp = widget.followUp;
    return ClientSectionCard(
      title: LocaleKeys.clientsHub_followUp.tr(),
      trailing: _editing ? null : ClientAddLink(onTap: _startEditing),
      child: _editing
          ? _editor(context)
          : followUp == null
              ? AppText(
                  LocaleKeys.clientsHub_noFollowUp.tr(),
                  fontSize: 9.5.sp,
                  color: AppColors.textSecondaryColor.themeColor,
                )
              : _summary(context, followUp),
    );
  }
}
