import 'package:equatable/equatable.dart';

class ProfileCardContactItem extends Equatable {
  final String type;
  final String label;
  final String value;
  final bool visible;

  const ProfileCardContactItem({
    required this.type,
    required this.label,
    required this.value,
    required this.visible,
  });

  bool get isShown => visible && value.trim().isNotEmpty;

  String get url {
    final trimmed = value.trim();
    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return trimmed;
    }
    final handle = trimmed.replaceFirst('@', '');
    return switch (type) {
      'whatsapp' =>
        'https://wa.me/${trimmed.replaceAll(RegExp(r'[^0-9]'), '')}',
      'instagram' => 'https://instagram.com/$handle',
      'x' => 'https://x.com/$handle',
      'snapchat' => 'https://snapchat.com/add/$handle',
      'tiktok' => 'https://tiktok.com/@$handle',
      'linkedin' => 'https://linkedin.com/in/$handle',
      _ => trimmed,
    };
  }

  factory ProfileCardContactItem.fromJson(Map<String, dynamic> json) =>
      ProfileCardContactItem(
        type: json['type'] as String? ?? '',
        label: json['label'] as String? ?? '',
        value: json['value']?.toString() ?? '',
        visible: json['visible'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'label': label,
        'value': value,
        'visible': visible,
      };

  @override
  List<Object?> get props => [type, label, value, visible];
}
