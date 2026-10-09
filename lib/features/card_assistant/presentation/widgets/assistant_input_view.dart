import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../logic/card_assistant_cubit.dart';
import 'assistant_error_box.dart';
import 'assistant_method_card.dart';
import 'assistant_source_field.dart';

class AssistantInputView extends StatelessWidget {
  const AssistantInputView({
    super.key,
    required this.source,
    required this.descriptionController,
    required this.linkController,
    required this.onSourceChanged,
    required this.onUseSampleDescription,
    required this.onUseSampleLink,
    required this.onChanged,
    this.error,
  });

  final AssistantSource source;
  final TextEditingController descriptionController;
  final TextEditingController linkController;
  final ValueChanged<AssistantSource> onSourceChanged;
  final VoidCallback onUseSampleDescription;
  final VoidCallback onUseSampleLink;
  final ValueChanged<String> onChanged;
  final String? error;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    final isDescription = source == AssistantSource.description;
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 25.h),
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Container(
            width: 51.w,
            height: 51.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.assistantSymbol.themeColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child:
                Icon(Icons.auto_awesome_outlined, size: 25.sp, color: accent),
          ),
        ),
        SizedBox(height: 21.h),
        AppText(
          LocaleKeys.cardAssistant_inputTitle.tr(),
          fontSize: 31.sp,
          fontWeight: FontWeight.w800,
          height: 1.3,
          letterSpacing: -0.6,
        ),
        SizedBox(height: 13.h),
        AppText(
          LocaleKeys.cardAssistant_inputSubtitle.tr(),
          fontSize: 11.sp,
          height: 1.9,
          color: AppColors.assistantBody.themeColor,
        ),
        SizedBox(height: 25.h),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: AssistantMethodCard(
                  icon: Icons.notes_rounded,
                  title: LocaleKeys.cardAssistant_describeTitle.tr(),
                  subtitle: LocaleKeys.cardAssistant_describeSubtitle.tr(),
                  selected: isDescription,
                  onTap: () => onSourceChanged(AssistantSource.description),
                ),
              ),
              9.width,
              Expanded(
                child: AssistantMethodCard(
                  icon: Icons.link_rounded,
                  title: LocaleKeys.cardAssistant_linkTitle.tr(),
                  subtitle: LocaleKeys.cardAssistant_linkSubtitle.tr(),
                  selected: !isDescription,
                  onTap: () => onSourceChanged(AssistantSource.link),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 26.h),
        if (isDescription)
          AssistantSourceField(
            key: const ValueKey('description'),
            label: LocaleKeys.cardAssistant_describeLabel.tr(),
            controller: descriptionController,
            hint: LocaleKeys.cardAssistant_describeHint.tr(),
            example: LocaleKeys.cardAssistant_describeExample.tr(),
            sampleLabel: LocaleKeys.cardAssistant_useSampleDescription.tr(),
            onUseSample: onUseSampleDescription,
            onChanged: onChanged,
          )
        else
          AssistantSourceField(
            key: const ValueKey('link'),
            label: LocaleKeys.cardAssistant_linkLabel.tr(),
            controller: linkController,
            hint: 'https://…',
            example: LocaleKeys.cardAssistant_linkExample.tr(),
            sampleLabel: LocaleKeys.cardAssistant_useSampleLink.tr(),
            onUseSample: onUseSampleLink,
            onChanged: onChanged,
            isLink: true,
          ),
        if (error != null) AssistantErrorBox(message: error!),
        Container(
          margin: EdgeInsets.only(top: error == null ? 25.h : 11.h),
          padding: EdgeInsets.only(top: 17.h),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: AppColors.assistantLine.themeColor),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Icon(Icons.check_rounded, size: 14.sp, color: accent),
              ),
              8.width,
              Expanded(
                child: AppText(
                  LocaleKeys.cardAssistant_assurance.tr(),
                  fontSize: 9.sp,
                  height: 1.9,
                  color: AppColors.assistantAssurance.themeColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
