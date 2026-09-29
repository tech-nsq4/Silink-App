import 'package:equatable/equatable.dart';

class Faq extends Equatable {
  final String id;
  final String question;
  final String answer;

  const Faq({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory Faq.fromJson(Map<String, dynamic> json) {
    return Faq(
      id: json['id']?.toString() ?? '',
      question: json['question'] as String? ?? '',
      answer: json['answer'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'question': question,
        'answer': answer,
      };

  @override
  List<Object?> get props => [id, question, answer];
}
