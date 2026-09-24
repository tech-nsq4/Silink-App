enum CompanyBusinessType {
  restaurant,
  cafe,
  clinic,
  mall,
  other;

  String get key => 'company.business_$name';
}
