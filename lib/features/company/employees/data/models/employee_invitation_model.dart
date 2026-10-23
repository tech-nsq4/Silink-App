import 'package:equatable/equatable.dart';

class EmployeeInvitationModel extends Equatable {
  const EmployeeInvitationModel({
    required this.status,
    required this.token,
    required this.invitationUrl,
    required this.deepLink,
    this.whatsappUrl = '',
    this.expiresAt,
    this.acceptedAt,
  });

  final String status;
  final String token;
  final String invitationUrl;
  final String deepLink;
  final String whatsappUrl;
  final DateTime? expiresAt;
  final DateTime? acceptedAt;

  String get shareLink {
    if (invitationUrl.isNotEmpty) return invitationUrl;
    if (token.isEmpty) return '';
    return 'https://silink-api.nasaq4.com/employee-invitations/$token';
  }

  factory EmployeeInvitationModel.fromJson(Map<String, dynamic> json) =>
      EmployeeInvitationModel(
        status: json['status'] as String? ?? '',
        token: json['token'] as String? ?? '',
        invitationUrl: json['invitationUrl'] as String? ?? '',
        deepLink: json['deepLink'] as String? ?? '',
        whatsappUrl: json['whatsappUrl'] as String? ?? '',
        expiresAt: DateTime.tryParse(json['expiresAt'] as String? ?? ''),
        acceptedAt: DateTime.tryParse(json['acceptedAt'] as String? ?? ''),
      );

  @override
  List<Object?> get props => [
        status,
        token,
        invitationUrl,
        deepLink,
        whatsappUrl,
        expiresAt,
        acceptedAt,
      ];
}
