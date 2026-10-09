import 'package:equatable/equatable.dart';

class StudioContact extends Equatable {
  const StudioContact({
    required this.type,
    this.value = '',
    this.visible = false,
  });

  static const List<String> channelTypes = [
    'whatsapp',
    'linkedin',
    'instagram',
    'x',
    'snapchat',
    'tiktok',
  ];

  static const List<String> linkTypes = [
    'website',
    'portfolio',
    'booking',
    'quote',
    'profile',
    'custom',
  ];

  final String type;
  final String value;
  final bool visible;

  bool get isShown => visible && value.trim().isNotEmpty;

  String get url {
    final trimmed = value.trim();
    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return trimmed;
    }
    final handle = trimmed.replaceFirst('@', '');
    return switch (type) {
      'whatsapp' => 'https://wa.me/${trimmed.replaceAll(RegExp(r'\D'), '')}',
      'instagram' => 'https://instagram.com/$handle',
      'x' => 'https://x.com/$handle',
      'snapchat' => 'https://snapchat.com/add/$handle',
      'tiktok' => 'https://tiktok.com/@$handle',
      'linkedin' => 'https://linkedin.com/in/$handle',
      _ => 'https://$trimmed',
    };
  }

  StudioContact copyWith({String? value, bool? visible}) => StudioContact(
        type: type,
        value: value ?? this.value,
        visible: visible ?? this.visible,
      );

  Map<String, dynamic> toJson() =>
      {'type': type, 'value': value.trim(), 'visible': visible};

  @override
  List<Object?> get props => [type, value, visible];
}
