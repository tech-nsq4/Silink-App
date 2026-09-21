import 'company_business_type.dart';

class Company {
  const Company({
    this.name = '',
    this.logoUrl = '',
    this.registrationNumber = '',
    this.taxNumber = '',
    this.activityDescription = '',
    this.email = '',
    this.phone = '',
    this.website = '',
    this.businessType = CompanyBusinessType.restaurant,
    this.activityNature = '',
    this.hasOnlineStore = false,
    this.city = '',
    this.district = '',
    this.employeesRange = '',
    this.brandColorHex = '1F8A70',
    this.showLogoOnBrand = true,
    this.slug = '',
    this.catalog = const [],
    this.createdAt = '',
  });

  final String name;
  final String logoUrl;
  final String registrationNumber;
  final String taxNumber;
  final String activityDescription;
  final String email;
  final String phone;
  final String website;
  final CompanyBusinessType businessType;
  final String activityNature;
  final bool hasOnlineStore;
  final String city;
  final String district;
  final String employeesRange;
  final String brandColorHex;
  final bool showLogoOnBrand;
  final String slug;
  final List<String> catalog;
  final String createdAt;

  String get initial => name.trim().isEmpty ? 'Q' : name.trim().substring(0, 1);

  String get publicLink =>
      'silink.sa/business/${slug.isEmpty ? 'company' : slug}';

  Company copyWith({
    String? name,
    String? logoUrl,
    String? registrationNumber,
    String? taxNumber,
    String? activityDescription,
    String? email,
    String? phone,
    String? website,
    CompanyBusinessType? businessType,
    String? activityNature,
    bool? hasOnlineStore,
    String? city,
    String? district,
    String? employeesRange,
    String? brandColorHex,
    bool? showLogoOnBrand,
    String? slug,
    List<String>? catalog,
    String? createdAt,
  }) {
    return Company(
      name: name ?? this.name,
      logoUrl: logoUrl ?? this.logoUrl,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      taxNumber: taxNumber ?? this.taxNumber,
      activityDescription: activityDescription ?? this.activityDescription,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      businessType: businessType ?? this.businessType,
      activityNature: activityNature ?? this.activityNature,
      hasOnlineStore: hasOnlineStore ?? this.hasOnlineStore,
      city: city ?? this.city,
      district: district ?? this.district,
      employeesRange: employeesRange ?? this.employeesRange,
      brandColorHex: brandColorHex ?? this.brandColorHex,
      showLogoOnBrand: showLogoOnBrand ?? this.showLogoOnBrand,
      slug: slug ?? this.slug,
      catalog: catalog ?? this.catalog,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'logo_url': logoUrl,
        'registration_number': registrationNumber,
        'tax_number': taxNumber,
        'activity_description': activityDescription,
        'email': email,
        'phone': phone,
        'website': website,
        'business_type': businessType.name,
        'activity_nature': activityNature,
        'has_online_store': hasOnlineStore,
        'city': city,
        'district': district,
        'employees_range': employeesRange,
        'brand_color': brandColorHex,
        'show_logo_on_brand': showLogoOnBrand,
        'slug': slug,
        'catalog': catalog,
        'created_at': createdAt,
      };

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        name: json['name'] as String? ?? '',
        logoUrl: json['logo_url'] as String? ?? '',
        registrationNumber: json['registration_number'] as String? ?? '',
        taxNumber: json['tax_number'] as String? ?? '',
        activityDescription: json['activity_description'] as String? ?? '',
        email: json['email'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        website: json['website'] as String? ?? '',
        businessType: CompanyBusinessType.values.firstWhere(
          (value) => value.name == json['business_type'],
          orElse: () => CompanyBusinessType.restaurant,
        ),
        activityNature: json['activity_nature'] as String? ?? '',
        hasOnlineStore: json['has_online_store'] as bool? ?? false,
        city: json['city'] as String? ?? '',
        district: json['district'] as String? ?? '',
        employeesRange: json['employees_range'] as String? ?? '',
        brandColorHex: json['brand_color'] as String? ?? '1F8A70',
        showLogoOnBrand: json['show_logo_on_brand'] as bool? ?? true,
        slug: json['slug'] as String? ?? '',
        catalog:
            (json['catalog'] as List<dynamic>?)?.cast<String>() ?? const [],
        createdAt: json['created_at'] as String? ?? '',
      );
}
