enum CompanyBusinessType {
  restaurant,
  cafe,
  clinic,
  mall,
  other;

  String get key => 'company.business_$name';

  String get titleKey {
    switch (this) {
      case CompanyBusinessType.restaurant:
        return 'company.business_restaurant';
      case CompanyBusinessType.cafe:
        return 'company.business_cafe';
      case CompanyBusinessType.clinic:
        return 'company.business_clinic';
      case CompanyBusinessType.mall:
        return 'company.business_mall';
      case CompanyBusinessType.other:
        return 'company.business_other';
    }
  }
}
