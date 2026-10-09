import 'package:flutter/material.dart';

import '../../../../core/utils/convert_helper.dart';
import '../../../../core/widgets/digital_card_preview.dart';
import '../../data/models/studio_design_options.dart';
import '../../data/models/studio_draft.dart';

class StudioDigitalCard extends StatelessWidget {
  const StudioDigitalCard({super.key, required this.draft, this.options});

  final StudioDraft draft;
  final StudioDesignOptions? options;

  @override
  Widget build(BuildContext context) {
    return DigitalCardPreview(
      name: draft.name,
      title: draft.title,
      company: draft.company,
      initials: draft.initials,
      accent: ConvertHelper.hexToColor(draft.primaryColor),
      template: draft.template,
      buttonRadius: options?.shape(draft.buttonShape)?.radius ??
          DigitalCardPreview.shapeRadii[draft.buttonShape] ??
          12,
      fontFamily: draft.fontFamily,
    );
  }
}
