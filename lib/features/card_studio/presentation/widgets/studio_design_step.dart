import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../data/models/studio_design_options.dart';
import '../../data/models/studio_draft.dart';
import 'studio_design_details.dart';
import 'studio_digital_card.dart';
import 'studio_editor_heading.dart';
import 'studio_labels.dart';
import 'studio_palette.dart';
import 'studio_preview_frame.dart';
import 'studio_section_order.dart';
import 'studio_section_title.dart';
import 'studio_select_field.dart';
import 'studio_template_choice.dart';

class StudioDesignStep extends StatelessWidget {
  const StudioDesignStep({
    super.key,
    required this.draft,
    required this.options,
    required this.loadingOptions,
    required this.onTemplateSelected,
    required this.onAppearanceChanged,
    required this.onChanged,
    required this.onReorderSections,
  });

  final StudioDraft draft;
  final StudioDesignOptions? options;
  final bool loadingOptions;
  final ValueChanged<String> onTemplateSelected;
  final ValueChanged<StudioDraft> onAppearanceChanged;
  final ValueChanged<StudioDraft> onChanged;
  final void Function(int oldIndex, int newIndex) onReorderSections;

  List<(String, String, String?)> get _templates {
    final remote = options?.templates.templates;
    if (remote == null || remote.isEmpty) {
      return [
        for (final slug in StudioDraft.templates)
          (slug, StudioLabels.template(slug), null),
      ];
    }
    return [for (final t in remote) (t.slug, t.label, t.badge)];
  }

  List<String> get _colors {
    final remote = options?.appearance.colors;
    return remote == null || remote.isEmpty ? StudioDraft.palette : remote;
  }

  @override
  Widget build(BuildContext context) {
    final appearance = options?.appearance;
    final backgrounds = appearance?.backgrounds ?? const [];
    final shapes = appearance?.shapes ?? const [];
    final fonts = appearance?.fonts ?? const [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StudioEditorHeading(
          title: LocaleKeys.cardStudio_designTitle.tr(),
          subtitle: LocaleKeys.cardStudio_designSubtitle.tr(),
        ),
        StudioPreviewFrame(
          background: options?.background(draft.background)?.color,
          child: StudioDigitalCard(draft: draft, options: options),
        ),
        if (loadingOptions) ...[
          SizedBox(height: 24.h),
          Center(
            child: CustomLoadingWidget(
              color: AppColors.accentTeal.themeColor,
              size: 28,
            ),
          ),
        ],
        StudioSectionTitle(title: LocaleKeys.cardStudio_styleTitle.tr()),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final (index, template) in _templates.indexed) ...[
                if (index > 0) 10.width,
                Expanded(
                  child: StudioTemplateChoice(
                    template: template.$1,
                    label: template.$2,
                    badge: template.$3,
                    selected: draft.template == template.$1,
                    onTap: () => onTemplateSelected(template.$1),
                  ),
                ),
              ],
            ],
          ),
        ),
        StudioSectionTitle(title: LocaleKeys.cardStudio_colorTitle.tr()),
        StudioPalette(
          colors: _colors,
          selected: draft.primaryColor,
          onSelected: (hex) =>
              onAppearanceChanged(draft.copyWith(primaryColor: hex)),
        ),
        StudioDesignDetails(
          title: LocaleKeys.cardStudio_designDetails.tr(),
          children: [
            StudioSelectField<String>(
              label: LocaleKeys.cardStudio_backgroundLabel.tr(),
              value: draft.background,
              options: backgrounds.isEmpty
                  ? StudioDraft.backgrounds
                  : [for (final b in backgrounds) b.type],
              labelOf: (type) =>
                  options?.background(type)?.label ??
                  StudioLabels.background(type),
              onChanged: (v) =>
                  onAppearanceChanged(draft.copyWith(background: v)),
            ),
            StudioSelectField<String>(
              label: LocaleKeys.cardStudio_shapeLabel.tr(),
              value: draft.buttonShape,
              options: shapes.isEmpty
                  ? StudioDraft.buttonShapes
                  : [for (final s in shapes) s.type],
              labelOf: (type) =>
                  options?.shape(type)?.label ?? StudioLabels.shape(type),
              onChanged: (v) =>
                  onAppearanceChanged(draft.copyWith(buttonShape: v)),
            ),
            StudioSelectField<String>(
              label: LocaleKeys.cardStudio_fontLabel.tr(),
              value: draft.fontFamily,
              options: fonts.isEmpty
                  ? StudioDraft.fonts
                  : [for (final f in fonts) f.family],
              labelOf: (family) =>
                  options?.fontByFamily(family)?.name ?? family,
              onChanged: (v) =>
                  onAppearanceChanged(draft.copyWith(fontFamily: v)),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 13.h),
          child: AppText(
            LocaleKeys.cardStudio_orderTitle.tr(),
            fontSize: 15.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        StudioSectionOrder(
          sections: draft.sections,
          labelOf: StudioLabels.section,
          onToggle: (index, visible) => onChanged(draft.copyWith(sections: [
            for (final (i, s) in draft.sections.indexed)
              i == index ? s.copyWith(visible: visible) : s,
          ])),
          onReorder: onReorderSections,
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
