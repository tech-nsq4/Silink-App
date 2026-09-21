import 'package:equatable/equatable.dart';

class TemplatePreviewColors extends Equatable {
  final String header;
  final String card;
  final String accent;

  const TemplatePreviewColors({
    required this.header,
    required this.card,
    required this.accent,
  });

  factory TemplatePreviewColors.fromJson(Map<String, dynamic> json) =>
      TemplatePreviewColors(
        header: json['header'] as String? ?? '#17B78F',
        card: json['card'] as String? ?? '#ffffff',
        accent: json['accent'] as String? ?? '#17B78F',
      );

  @override
  List<Object?> get props => [header, card, accent];
}

class TemplateModel extends Equatable {
  final String id;
  final String slug;
  final String label;
  final String description;
  final String badge;
  final bool paid;
  final TemplatePreviewColors preview;

  const TemplateModel({
    required this.id,
    required this.slug,
    required this.label,
    required this.description,
    required this.badge,
    required this.paid,
    required this.preview,
  });

  factory TemplateModel.fromJson(Map<String, dynamic> json) => TemplateModel(
        id: json['id']?.toString() ?? '',
        slug: json['slug'] as String? ?? '',
        label: json['label'] as String? ?? '',
        description: json['description'] as String? ?? '',
        badge: json['badge'] as String? ?? '',
        paid: json['paid'] as bool? ?? false,
        preview: TemplatePreviewColors.fromJson(
            json['preview'] as Map<String, dynamic>? ?? const {}),
      );

  @override
  List<Object?> get props =>
      [id, slug, label, description, badge, paid, preview];
}

class TemplateSettings extends Equatable {
  final String title;
  final String hint;
  final String selectedId;
  final List<TemplateModel> templates;

  const TemplateSettings({
    required this.title,
    required this.hint,
    required this.selectedId,
    required this.templates,
  });

  factory TemplateSettings.fromJson(Map<String, dynamic> json) =>
      TemplateSettings(
        title: json['title'] as String? ?? '',
        hint: json['hint'] as String? ?? '',
        selectedId: json['selected'] as String? ?? '',
        templates: (json['templates'] as List<dynamic>? ?? [])
            .map((e) => TemplateModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  TemplateSettings copyWith({String? selectedId}) => TemplateSettings(
        title: title,
        hint: hint,
        selectedId: selectedId ?? this.selectedId,
        templates: templates,
      );

  @override
  List<Object?> get props => [title, hint, selectedId, templates];
}
