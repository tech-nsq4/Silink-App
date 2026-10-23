import 'package:equatable/equatable.dart';

class ContactMessage extends Equatable {
  const ContactMessage({
    required this.name,
    required this.email,
    required this.phone,
    required this.subject,
    required this.message,
  });

  final String name;
  final String email;
  final String phone;
  final String subject;
  final String message;

  Map<String, dynamic> toJson() => {
        'name': name.trim(),
        'email': email.trim(),
        'phone': phone.trim(),
        'subject': subject.trim(),
        'message': message.trim(),
      };

  @override
  List<Object?> get props => [name, email, phone, subject, message];
}
