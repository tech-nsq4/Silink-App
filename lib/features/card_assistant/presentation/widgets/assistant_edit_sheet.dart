import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/gradient_action_button.dart';
import '../../data/models/assistant_draft.dart';
import 'assistant_error_box.dart';

class AssistantEditSheet extends StatefulWidget {
  const AssistantEditSheet({super.key, required this.draft, this.error});

  final AssistantDraft draft;
  final String? error;

  static Future<AssistantDraft?> show(
    BuildContext context, {
    required AssistantDraft draft,
    String? error,
  }) =>
      showModalBottomSheet<AssistantDraft>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: AppColors.profileHero.themeColor.withValues(alpha: 0.53),
        builder: (_) => AssistantEditSheet(draft: draft, error: error),
      );

  @override
  State<AssistantEditSheet> createState() => _AssistantEditSheetState();
}

class _AssistantEditSheetState extends State<AssistantEditSheet> {
  late final Map<String, TextEditingController> _controllers = {
    'name': TextEditingController(text: widget.draft.name),
    'title': TextEditingController(text: widget.draft.title),
    'company': TextEditingController(text: widget.draft.company),
    'bio': TextEditingController(text: widget.draft.bio),
    'phone': TextEditingController(text: widget.draft.phone),
    'email': TextEditingController(text: widget.draft.email),
    'location': TextEditingController(text: widget.draft.location),
    'services': TextEditingController(text: widget.draft.services),
    'website': TextEditingController(text: widget.draft.website),
  };

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  String _value(String key) => _controllers[key]!.text.trim();

  void _save() => Navigator.pop(
        context,
        widget.draft.copyWith(
          name: _value('name'),
          title: _value('title'),
          company: _value('company'),
          bio: _value('bio'),
          phone: _value('phone'),
          email: _value('email'),
          location: _value('location'),
          services: _value('services'),
          website: _value('website'),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final fields = <(String, String)>[
      ('name', LocaleKeys.cardAssistant_fieldName.tr()),
      ('title', LocaleKeys.cardAssistant_fieldTitle.tr()),
      ('company', LocaleKeys.cardAssistant_fieldCompany.tr()),
      ('bio', LocaleKeys.cardAssistant_fieldBio.tr()),
      ('phone', LocaleKeys.cardAssistant_fieldPhone.tr()),
      ('email', LocaleKeys.cardAssistant_fieldEmail.tr()),
      ('location', LocaleKeys.cardAssistant_fieldLocation.tr()),
      ('services', LocaleKeys.cardAssistant_fieldServices.tr()),
      ('website', LocaleKeys.cardAssistant_fieldWebsite.tr()),
    ];
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
              24.w, 24.h, 24.w, 24.h + MediaQuery.paddingOf(context).bottom),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  LocaleKeys.cardAssistant_editSheetTitle.tr(),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
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
                        size: 18.sp,
                        color: AppColors.assistantSourceIcon.themeColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 23.h),
            for (final (key, label) in fields) ...[
              AppText(
                label,
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.fieldLabel.themeColor,
              ),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: _controllers[key],
                hint: label,
                maxLines: key == 'bio' ? 3 : 1,
              ),
              SizedBox(height: 16.h),
            ],
            if (widget.error != null) AssistantErrorBox(message: widget.error!),
            GradientActionButton(
              title: LocaleKeys.cardAssistant_backToPreview.tr(),
              icon: Icons.check_rounded,
              onTap: _save,
              minHeight: 46,
            ),
          ],
        ),
      ),
    );
  }
}
