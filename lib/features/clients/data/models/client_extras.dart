import 'package:equatable/equatable.dart';

class ClientFollowUp extends Equatable {
  const ClientFollowUp({required this.at, this.text = ''});

  final DateTime at;
  final String text;

  factory ClientFollowUp.fromJson(Map<String, dynamic> json) => ClientFollowUp(
        at: DateTime.tryParse(json['at'] as String? ?? '') ?? DateTime.now(),
        text: json['text'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {'at': at.toIso8601String(), 'text': text};

  @override
  List<Object?> get props => [at, text];
}

class ClientNote extends Equatable {
  const ClientNote({required this.text, required this.createdAt});

  final String text;
  final DateTime createdAt;

  factory ClientNote.fromJson(Map<String, dynamic> json) => ClientNote(
        text: json['text'] as String? ?? '',
        createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
            DateTime.now(),
      );

  Map<String, dynamic> toJson() =>
      {'text': text, 'createdAt': createdAt.toIso8601String()};

  @override
  List<Object?> get props => [text, createdAt];
}
