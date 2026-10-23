import 'package:equatable/equatable.dart';

class RemotePage extends Equatable {
  const RemotePage({
    required this.slug,
    required this.title,
    required this.content,
  });

  final String slug;
  final String title;
  final String content;

  List<String> get paragraphs => content
      .split(RegExp(r'\n+'))
      .map((paragraph) => paragraph.trim())
      .where((paragraph) => paragraph.isNotEmpty)
      .toList();

  factory RemotePage.fromJson(Map<String, dynamic> json) => RemotePage(
        slug: json['slug'] as String? ?? '',
        title: json['title'] as String? ?? '',
        content: json['content'] as String? ?? '',
      );

  @override
  List<Object?> get props => [slug, title, content];
}
