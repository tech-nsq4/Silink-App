import 'company_business_type.dart';

class CompanyTeamMember {
  const CompanyTeamMember({
    required this.fullName,
    this.jobTitle,
    this.department,
  });

  final String fullName;
  final String? jobTitle;
  final String? department;
}

class CompanyPublicPageData {
  const CompanyPublicPageData({
    required this.name,
    required this.slug,
    this.businessType = CompanyBusinessType.restaurant,
    this.industry,
    this.city,
    this.employeesLabel,
    this.about,
    this.catalogLabel,
    this.imagePath,
    this.team = const <CompanyTeamMember>[],
  });

  final String name;
  final String slug;
  final CompanyBusinessType businessType;
  final String? industry;
  final String? city;
  final String? employeesLabel;
  final String? about;
  final String? catalogLabel;
  final String? imagePath;
  final List<CompanyTeamMember> team;

  CompanyPublicPageData withImagePath(String? value) => CompanyPublicPageData(
        name: name,
        slug: slug,
        businessType: businessType,
        industry: industry,
        city: city,
        employeesLabel: employeesLabel,
        about: about,
        catalogLabel: catalogLabel,
        imagePath: value,
        team: team,
      );

  static const CompanyPublicPageData sample = CompanyPublicPageData(
    name: 'مطعم دار الضيافة',
    slug: 'dardhliafa',
    businessType: CompanyBusinessType.restaurant,
    industry: 'مطاعم ومقاهي',
    city: 'الرياض',
    employeesLabel: '11-50',
    about: 'ماكولات سعودية أصيلة وضيافة دافئة – قائمة يومية ومناسبات',
    catalogLabel: 'قائمة الطعام',
    team: <CompanyTeamMember>[
      CompanyTeamMember(
        fullName: 'سارة المطيري',
        jobTitle: 'مديرة تسويق',
        department: 'التسويق',
      ),
    ],
  );
}
