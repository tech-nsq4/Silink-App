import 'package:equatable/equatable.dart';

import '../../../data/models/company_public_page_data.dart';
import '../../../employees/data/models/company_employee_model.dart';

class CompanyDashboardInfo extends Equatable {
  final String companyName;
  final String industry;
  final String city;
  final String? logoUrl;
  final List<CompanyEmployeeModel> team;
  final String about;
  final String website;
  final String email;
  final String phone;
  final String size;

  const CompanyDashboardInfo({
    required this.companyName,
    required this.industry,
    required this.city,
    this.logoUrl,
    this.team = const [],
    this.about = '',
    this.website = '',
    this.email = '',
    this.phone = '',
    this.size = '',
  });

  CompanyPublicPageData toPublicPage() => CompanyPublicPageData(
        name: companyName,
        slug: '',
        industry: industry,
        city: city,
        employeesLabel: size,
        about: about,
        logoUrl: logoUrl,
        phone: phone,
        email: email,
        website: website,
        team: [
          for (final member in team)
            if (member.status == CompanyEmployeeStatus.active)
              CompanyTeamMember(
                fullName: member.name,
                jobTitle: member.position,
              ),
        ],
      );

  int get activeMembers => team
      .where((member) => member.status == CompanyEmployeeStatus.active)
      .length;
  int get activeCards => team.where((member) => member.hasNfc).length;
  int get visits => team.fold(0, (sum, member) => sum + member.visits);
  int get leads => team.fold(0, (sum, member) => sum + member.leads);

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
  List<Object?> get props => [
        companyName,
        industry,
        city,
        logoUrl,
        team,
        about,
        website,
        email,
        phone,
        size,
      ];
}
