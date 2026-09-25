import 'package:equatable/equatable.dart';

class ProfileCardBasicInfo extends Equatable {
  final String fullName;
  final String jobTitle;
  final String company;
  final String phone;
  final String email;
  final String? photoUrl;
  final String address;

  const ProfileCardBasicInfo({
    this.fullName = '',
    this.jobTitle = '',
    this.company = '',
    this.phone = '',
    this.email = '',
    this.photoUrl,
    this.address = '',
  });

  factory ProfileCardBasicInfo.fromJson(Map<String, dynamic> json) =>
      ProfileCardBasicInfo(
        fullName: json['fullName'] as String? ?? '',
        jobTitle: json['jobTitle'] as String? ?? '',
        company: json['company'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        email: json['email'] as String? ?? '',
        photoUrl: json['photoUrl'] as String?,
        address: json['address'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'jobTitle': jobTitle,
        'company': company,
        'phone': phone,
        'email': email,
        'photoUrl': photoUrl,
        'address': address,
      };

  @override
  List<Object?> get props =>
      [fullName, jobTitle, company, phone, email, photoUrl, address];
}
