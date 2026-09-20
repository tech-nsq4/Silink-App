import 'package:equatable/equatable.dart';

class RegistrationTicket extends Equatable {
  final String registrationId;
  final String phone;
  final DateTime? expiresAt;

  const RegistrationTicket({
    required this.registrationId,
    required this.phone,
    this.expiresAt,
  });

  factory RegistrationTicket.fromJson(Map<String, dynamic> json) =>
      RegistrationTicket(
        registrationId: json['registrationId'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        expiresAt: json['expiresAt'] != null
            ? DateTime.tryParse(json['expiresAt'] as String)
            : null,
      );

  @override
  List<Object?> get props => [registrationId, phone, expiresAt];
}
