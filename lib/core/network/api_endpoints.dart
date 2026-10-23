class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://silink-api.nasaq4.com/api/v1/';

  // ─── Auth ─────────────────────────────────────────────────────────────────
  static const String login = 'auth/login';
  static const String profile = 'me/profile';
  static const String mePassword = 'me/password';
  static const String meFcmToken = 'me/fcm-token';
  static const String register = 'auth/register';
  static const String verifyOtp = 'auth/otp/verify';

  // ─── Employee Invitation ──────────────────────────────────────────────────
  static const String employeeInvitation = 'employee-invitations';
  static const String employeeInvitationAccept = 'employee-invitations/accept';

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
  static String meCompanyTeamMemberInvitation(String id) =>
      'me/company/team/$id/invitation';
  static String meCompanyTeamMemberStatus(String id) =>
      'me/company/team/$id/status';

  static const String meFiles = 'me/files';
  static const String meFileCategories = 'me/file-categories';
  static String meFile(String id) => 'me/files/$id';

  static const String meProducts = 'me/products';
  static String meProduct(String id) => 'me/products/$id';

  static const String meClients = 'me/clients';
  static String meClient(String id) => 'me/clients/$id';
  static const String meClientCategories = 'me/client-categories';

  // ─── Store ────────────────────────────────────────────────────────────────
  static const String nfcProducts = 'nfc-products';
  static const String meOrders = 'me/orders';
  static const String cities = 'cities';
  static String meOrderCancel(String id) => 'me/orders/$id/cancel';

  // ─── Subscriptions ────────────────────────────────────────────────────────
  static const String subscriptions = 'subscriptions';

  // ─── FAQs ─────────────────────────────────────────────────────────────────
  static const String faqs = 'faqs';
  static const String pages = 'pages';
  static const String splash = 'splash';
  static const String contactMessages = 'contact-messages';
  static const String mePortfolios = 'me/portfolios';
  static String mePortfolio(String id) => 'me/portfolios/$id';
  static String mePortfolioStatus(String id) => 'me/portfolios/$id/status';
}
