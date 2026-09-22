import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/convert_helper.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/screen_state_layout.dart';
import 'package:Silink/features/profile_completion/logic/profile_completion_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/template_option_card.dart';

class TemplateSelectionStep extends StatefulWidget {
  const TemplateSelectionStep({super.key});

  @override
  State<TemplateSelectionStep> createState() => _TemplateSelectionStepState();
}

class _TemplateSelectionStepState extends State<TemplateSelectionStep> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCompletionCubit>().loadTemplates();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCompletionCubit, ProfileCompletionState>(
      builder: (context, state) {
        return CustomScreenStateLayout(
          isLoading: state.templatesLoading && state.templates == null,
          error: state.templatesError != null
              ? ErrorModel(
                  code: ErrorEnum.otherError,
                  errorMessage: state.templatesError!,
                )
              : null,
          onRetry: () =>
              context.read<ProfileCompletionCubit>().loadTemplates(force: true),
          builder: (context) {
            final settings = state.templates;
            if (settings == null) return const SizedBox.shrink();
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    settings.title.isEmpty
                        ? LocaleKeys.template_title.tr()
                        : settings.title,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                  ),
                  4.height,
                  AppText(
                    settings.hint.isEmpty
                        ? LocaleKeys.template_subtitle.tr()
                        : settings.hint,
                    fontSize: 14.sp,
                  ),
                  16.height,
                  for (final template in settings.templates) ...[
                    TemplateOptionCard(
                      previewColor: ConvertHelper.hexToColor(template.preview.header),
                      title: template.label,
                      subtitle: template.description,
                      badgeLabel: template.badge,
                      badgeIcon: template.paid
                          ? Icons.star_rounded
                          : Icons.check_circle,
                      badgeColor: template.paid
                          ? const Color(0xFFFEF9C3)
                          : const Color(0xFFDCFCE7),
                      badgeTextColor: template.paid
                          ? const Color(0xFF854D0E)
                          : const Color(0xFF166534),
                      selected: settings.selectedId == template.id,
                      onTap: () => context
                          .read<ProfileCompletionCubit>()
                          .selectTemplate(template.id),
                    ),
                    12.height,
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}
