import 'package:equatable/equatable.dart';

class CompanyDashboardInfo extends Equatable {
  final String companyName;
  final String industry;
  final String city;
  final String? logoUrl;

  const CompanyDashboardInfo({
    required this.companyName,
    required this.industry,
    required this.city,
    this.logoUrl,
  });

  factory CompanyDashboardInfo.fromJson(Map<String, dynamic> json) =>
      CompanyDashboardInfo(
        companyName: json['companyName'] as String? ?? '',
        industry: json['industry'] as String? ?? '',
        city: json['city'] as String? ?? '',
        logoUrl: json['logoUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'companyName': companyName,
        'industry': industry,
        'city': city,
        'logoUrl': logoUrl,
      };

  @override
  List<Object?> get props => [companyName, industry, city, logoUrl];
}
