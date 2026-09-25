import 'package:equatable/equatable.dart';

class ProfileCardLeadRequest extends Equatable {
  final String fullName;
  final String phone;
  final String email;
  final String company;
  final String jobTitle;
  final String message;
  final bool consent;

  const ProfileCardLeadRequest({
    required this.fullName,
    required this.phone,
    required this.email,
    required this.company,
    required this.jobTitle,
    required this.message,
    required this.consent,
  });

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        if (phone.isNotEmpty) 'phone': phone,
        if (email.isNotEmpty) 'email': email,
        if (company.isNotEmpty) 'company': company,
        if (jobTitle.isNotEmpty) 'jobTitle': jobTitle,
        if (message.isNotEmpty) 'message': message,
        'consent': consent,
      };

  @override
  List<Object?> get props =>
      [fullName, phone, email, company, jobTitle, message, consent];
}
