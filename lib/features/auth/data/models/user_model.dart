import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String fullName;
  final String phone;
  final String? email;
  final String? photoUrl;
  final String? status;
  final String? usageIntent;
  final String? createdAt;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.phone,
    this.email,
    this.photoUrl,
    this.status,
    this.usageIntent,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id']?.toString() ?? '',
        fullName:
            json['fullName'] as String? ?? json['name'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        email: json['email'] as String?,
        photoUrl: json['photoUrl'] as String? ?? json['photo'] as String?,
        status: json['status'] as String?,
        usageIntent: json['usageIntent'] as String?,
        createdAt:
            json['createdAt'] as String? ?? json['created_at'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'phone': phone,
        'email': email,
        'photoUrl': photoUrl,
        'status': status,
        'usageIntent': usageIntent,
        'createdAt': createdAt,
      };

  @override
  List<Object?> get props =>
      [id, fullName, phone, email, photoUrl, status, usageIntent, createdAt];
}
