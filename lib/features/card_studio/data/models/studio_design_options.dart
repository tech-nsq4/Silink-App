import 'package:equatable/equatable.dart';

import '../../../profile_completion/data/models/appearance_model.dart';
import '../../../profile_completion/data/models/template_model.dart';

class StudioDesignOptions extends Equatable {
  const StudioDesignOptions(
      {required this.templates, required this.appearance});

  final TemplateSettings templates;
  final AppearanceModel appearance;

  String? get selectedTemplateSlug => templates.templates
      .where((t) => t.id == templates.selectedId)
      .map((t) => t.slug)
      .firstOrNull;

  String? get selectedFontFamily => appearance.fonts
      .where((f) => f.id == appearance.fontId)
      .map((f) => f.family)
      .firstOrNull;

  TemplateModel? templateBySlug(String slug) =>
      templates.templates.where((t) => t.slug == slug).firstOrNull;

  AppearanceFont? fontByFamily(String family) => appearance.fonts
      .where((f) => f.family.toLowerCase() == family.toLowerCase())
      .firstOrNull;

  AppearanceBackground? background(String type) =>
      appearance.backgrounds.where((b) => b.type == type).firstOrNull;

  AppearanceShape? shape(String type) =>
      appearance.shapes.where((s) => s.type == type).firstOrNull;

  StudioDesignOptions copyWith({
    TemplateSettings? templates,
    AppearanceModel? appearance,
  }) =>
      StudioDesignOptions(
        templates: templates ?? this.templates,
        appearance: appearance ?? this.appearance,
      );

  @override
  List<Object?> get props => [templates, appearance];
}
