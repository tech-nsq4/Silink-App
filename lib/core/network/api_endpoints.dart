class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://silink-api.nsq4.sa/api/v1/';

  // ─── Auth ─────────────────────────────────────────────────────────────────
  static const String login = 'auth/login';
  static const String profile = 'me/profile';
  static const String register = 'auth/register';
  static const String verifyOtp = 'auth/otp/verify';

  // ─── Profile Completion ───────────────────────────────────────────────────
  static const String meChannels = 'me/channels';
  static const String meLinks = 'me/links';
  static const String meCatalog = 'me/catalog';
  static const String meCatalogItems = 'me/catalog/items';
  static String meCatalogItem(String kind, String id) =>
      kind == 'service' ? 'me/services/$id' : 'me/products/$id';
  static const String meArrangement = 'me/arrangement';
  static const String meTemplate = 'me/template';
  static const String meAppearance = 'me/appearance';

  // ─── Profile Card ─────────────────────────────────────────────────────────
  static const String meCard = 'me/card';

  // ─── Company Profile Completion ───────────────────────────────────────────
  static const String meCompany = 'me/company';
  static const String meCompanyIndustry = 'me/company/industry';
  static const String meCompanySubIndustry = 'me/company/sub-industry';
  static const String meCompanyDetails = 'me/company/details';

  // ─── Company Team ─────────────────────────────────────────────────────────
  static const String meCompanyTeam = 'me/company/team';
  static String meCompanyTeamMember(String id) => 'me/company/team/$id';

  static const String meFiles = 'me/files';
  static const String meFileCategories = 'me/file-categories';
  static String meFile(String id) => 'me/files/$id';

  // ─── Store ────────────────────────────────────────────────────────────────
  static const String nfcProducts = 'nfc-products';
  static const String meOrders = 'me/orders';
  static const String cities = 'cities';
  static String meOrderCancel(String id) => 'me/orders/$id/cancel';

  // ─── Subscriptions ────────────────────────────────────────────────────────
  static const String subscriptions = 'subscriptions';

  // ─── FAQs ─────────────────────────────────────────────────────────────────
  static const String faqs = 'faqs';
}
