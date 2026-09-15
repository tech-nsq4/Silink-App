import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/profile_completion/models/profile_completion_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/template_option_card.dart';

class TemplateSelectionStep extends StatefulWidget {
  const TemplateSelectionStep({super.key, required this.data});

  final ProfileCompletionData data;

  @override
  State<TemplateSelectionStep> createState() => _TemplateSelectionStepState();
}

class _TemplateSelectionStepState extends State<TemplateSelectionStep> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            LocaleKeys.template_title.tr(),
            fontSize: 20.sp,
            fontWeight: FontWeight.w800,
          ),
          4.height,
          AppText(
            LocaleKeys.template_subtitle.tr(),
            fontSize: 14.sp,
          ),
          16.height,
          TemplateOptionCard(
            previewColor: const Color(0xFF17B78F),
            title: LocaleKeys.template_simpleTitle.tr(),
            subtitle: LocaleKeys.template_simpleSubtitle.tr(),
            badgeLabel: LocaleKeys.template_freeBadge.tr(),
            badgeIcon: Icons.check_circle,
            badgeColor: const Color(0xFFDCFCE7),
            badgeTextColor: const Color(0xFF166534),
            selected: widget.data.template == ProfileTemplate.simple,
            onTap: () =>
                setState(() => widget.data.template = ProfileTemplate.simple),
          ),
          12.height,
          TemplateOptionCard(
            previewColor: const Color(0xFF17212B),
            title: LocaleKeys.template_professionalTitle.tr(),
            subtitle: LocaleKeys.template_professionalSubtitle.tr(),
            badgeLabel: LocaleKeys.template_paidBadge.tr(),
            badgeIcon: Icons.star_rounded,
            badgeColor: const Color(0xFFFEF9C3),
            badgeTextColor: const Color(0xFF854D0E),
            selected: widget.data.template == ProfileTemplate.professional,
            onTap: () => setState(
                () => widget.data.template = ProfileTemplate.professional),
          ),
          12.height,
          TemplateOptionCard(
            previewColor: const Color(0xFF8B5CF6),
            title: LocaleKeys.template_personalTitle.tr(),
            subtitle: LocaleKeys.template_personalSubtitle.tr(),
            badgeLabel: LocaleKeys.template_freeBadge.tr(),
            badgeIcon: Icons.check_circle,
            badgeColor: const Color(0xFFDCFCE7),
            badgeTextColor: const Color(0xFF166534),
            selected: widget.data.template == ProfileTemplate.personal,
            onTap: () => setState(
                () => widget.data.template = ProfileTemplate.personal),
          ),
        ],
      ),
    );
  }
}
