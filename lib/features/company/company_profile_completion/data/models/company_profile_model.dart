import 'package:equatable/equatable.dart';

class CompanyProfileModel extends Equatable {
  final String userId;
  final String step;
  final String title;
  final String companyName;
  final String about;
  final String website;
  final String? logoUrl;

  const CompanyProfileModel({
    required this.userId,
    required this.step,
    required this.title,
    required this.companyName,
    required this.about,
    required this.website,
    this.logoUrl,
  });

  factory CompanyProfileModel.fromJson(Map<String, dynamic> json) =>
      CompanyProfileModel(
        userId: json['userId'] as String? ?? '',
        step: json['step'] as String? ?? '',
        title: json['title'] as String? ?? '',
        companyName: json['companyName'] as String? ?? '',
        about: json['about'] as String? ?? '',
        website: json['website'] as String? ?? '',
        logoUrl: json['logoUrl'] as String?,
      );

  @override
  List<Object?> get props =>
      [userId, step, title, companyName, about, website, logoUrl];
}
