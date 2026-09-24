import 'package:Silink/features/account/presentation/account_edit_screen.dart';
import 'package:Silink/features/account/presentation/account_guest_screen.dart';
import 'package:Silink/features/account/presentation/account_screen.dart';
import 'package:Silink/features/auth/data/models/user_model.dart';
import 'package:Silink/features/clients/models/client_model.dart';
import 'package:Silink/features/clients/presentation/client_details_screen.dart';
<<<<<<< HEAD
import 'package:Silink/features/company/presentation/brand_screen.dart';
import 'package:Silink/features/company/presentation/cards_screen.dart';
import 'package:Silink/features/company/catalog/presentation/catalog_item_screen.dart';
import 'package:Silink/features/company/catalog/presentation/catalog_screen.dart';
import 'package:Silink/features/company/data/models/company_business_type.dart';
import 'package:Silink/features/company/data/models/company_catalog_item.dart';
import 'package:Silink/features/company/data/models/company_employee.dart';
import 'package:Silink/features/company/data/models/company_public_page_data.dart';
import 'package:Silink/features/company/employees/presentation/employee_details_screen.dart';
import 'package:Silink/features/company/employees/presentation/employee_digital_profile_screen.dart';
import 'package:Silink/features/company/employees/presentation/employee_edit_screen.dart';
import 'package:Silink/features/company/employees/presentation/employee_nfc_link_screen.dart';
import 'package:Silink/features/company/presentation/dashboard_screen.dart';
import 'package:Silink/features/company/presentation/edit_screen.dart';
import 'package:Silink/features/company/employees/presentation/employees_screen.dart';
import 'package:Silink/features/company/presentation/invite_screen.dart';
import 'package:Silink/features/nfc/presentation/nfc_screen.dart';
import 'package:Silink/features/company/presentation/publish_screen.dart';
import 'package:Silink/features/company/presentation/public_page_screen.dart';
import 'package:Silink/features/company/presentation/qr_screen.dart';
import 'package:Silink/features/company/presentation/setup_screen.dart';
import 'package:Silink/features/company/presentation/success_screen.dart';
=======

>>>>>>> 0ecc604e79f8296123f1d0d807b0097f196b95cd
import 'package:Silink/features/help/presentation/help_screen.dart';
import 'package:Silink/features/notifications/presentation/notifications_screen.dart';
import 'package:Silink/features/privacy/presentation/privacy_screen.dart';
import 'package:Silink/features/profile_completion/data/models/profile_completion_data.dart';
import 'package:Silink/features/profile_completion/presentation/profile_completion_screen.dart';
import 'package:Silink/features/my_card/models/my_card_model.dart';
import 'package:Silink/features/my_card/presentation/my_card_details_screen.dart';
import 'package:Silink/features/my_card/presentation/public_profile_preview_screen.dart';
import 'package:Silink/features/my_card/presentation/published_screen.dart';
import 'package:Silink/features/my_card/presentation/qr_code_screen.dart';
import 'package:Silink/features/auth/presentation/usage_type_screen.dart';
import 'package:Silink/features/services/presentation/service_details_screen.dart';
import 'package:Silink/features/statistics/presentation/statistics_screen.dart';
import 'package:Silink/features/store/models/product.dart';
import 'package:Silink/features/store/presentation/card_customization_screen.dart';
import 'package:Silink/features/store/presentation/cart_screen.dart';
import 'package:Silink/features/store/presentation/category_products_screen.dart';
import 'package:Silink/features/store/presentation/checkout_screen.dart';
import 'package:Silink/features/store/presentation/order_success_screen.dart';
import 'package:Silink/features/store/presentation/payment_screen.dart';
import 'package:Silink/features/store/presentation/product_details_screen.dart';
import 'package:Silink/features/store/presentation/store_screen.dart';
import 'package:Silink/features/subscription/presentation/subscription_screen.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/otp_screen.dart';
import '../../features/auth/presentation/personal_register_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/company/company_card/presentation/company_cards_screen.dart';
import '../../features/company/company_card/presentation/company_publish_screen.dart';
import '../../features/company/company_card/presentation/company_qr_screen.dart';
import '../../features/company/company_catalog/presentation/company_catalog_screen.dart';
import '../../features/company/company_dashboard/presentation/company_dashboard_screen.dart';
import '../../features/company/company_profile_completion/presentation/company_setup_screen.dart';
import '../../features/company/company_profile_completion/presentation/company_success_screen.dart';
import '../../features/company/company_settings/presentation/company_brand_screen.dart';
import '../../features/company/company_settings/presentation/company_edit_screen.dart';
import '../../features/company/company_team/presentation/company_employees_screen.dart';
import '../../features/layout/presentation/layout_screen.dart';
import '../../features/onboarding/presentation/on_boarding_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import 'routes.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case Routes.splashScreen:
        return _pageRoute(const SplashScreen());

      case Routes.onBoardingScreen:
        return _pageRoute(const OnBoardingScreen());

      case Routes.loginScreen:
        return _pageRoute(const LoginScreen());

      case Routes.registerScreen:
        return _pageRoute(const RegisterScreen());

      case Routes.otpScreen:
        return _pageRoute(OtpScreen(
          destination: arguments?['destination'] as String? ?? '',
          registrationId: arguments?['registrationId'] as String? ?? '',
          expiresAt: arguments?['expiresAt'] as DateTime?,
        ));

      case Routes.layoutScreen:
        return _pageRoute(LayoutScreen(
          currentPage: arguments?['currentPage'] ?? 0,
          cardData: arguments?['data'] as ProfileCompletionData?,
        ));

      case Routes.usageTypeScreen:
        return _pageRoute(const UsageTypeScreen());
      case Routes.personalRegisterScreen:
        return _pageRoute(PersonalRegisterScreen(
          usageIntent: arguments?['usageIntent'] as String? ?? 'personal',
        ));
      case Routes.profileCompletionScreen:
        return _pageRoute(const ProfileCompletionScreen());
      case Routes.statisticsScreen:
        return _pageRoute(const StatisticsScreen());
      case Routes.storeScreen:
        return _pageRoute(const StoreScreen());
      case Routes.publishedScreen:
        return _pageRoute(PublishedScreen(
          data: (arguments?['data'] as ProfileCompletionData?) ??
              ProfileCompletionData(),
        ));
      case Routes.qrCodeScreen:
        return _pageRoute(QrCodeScreen(
          data: (arguments?['data'] as ProfileCompletionData?) ??
              ProfileCompletionData(),
        ));
      case Routes.publicProfilePreviewScreen:
        return _pageRoute(PublicProfilePreviewScreen(
          data: (arguments?['data'] as ProfileCompletionData?) ??
              ProfileCompletionData(),
        ));
      case Routes.serviceDetailsScreen:
        return _pageRoute(ServiceDetailsScreen());
      case Routes.productDetailsScreen:
        return _pageRoute(ProductDetailsScreen(
          productId: arguments?['productId'] as String? ?? '',
        ));
      case Routes.categoryProductsScreen:
        return _pageRoute(CategoryProductsScreen(
          category: arguments?['category'] as ProductCategory?,
        ));
      case Routes.cardCustomizationScreen:
        return _pageRoute(CardCustomizationScreen(
          productId: arguments?['productId'] as String? ?? '',
        ));
      case Routes.cartScreen:
        return _pageRoute(const CartScreen());
      case Routes.checkoutScreen:
        return _pageRoute(const CheckoutScreen());
      case Routes.paymentScreen:
        return _pageRoute(const PaymentScreen());
      case Routes.orderSuccessScreen:
        return _pageRoute(const OrderSuccessScreen());
      case Routes.accountGuestScreen:
        return _pageRoute(const AccountGuestScreen());
      case Routes.accountScreen:
        return _pageRoute(const AccountScreen());
      case Routes.accountEditScreen:
        return _pageRoute(AccountEditScreen(
          user: arguments?['user'] as UserModel? ??
              UserModel(
                id: '',
                fullName: '',
                phone: '',
              ),
        ));
      case Routes.notificationsScreen:
        return _pageRoute(const NotificationsScreen());
      case Routes.privacyScreen:
        return _pageRoute(PrivacyScreen(
          username: arguments?['username'] as String? ?? '',
        ));
      case Routes.subscriptionScreen:
        return _pageRoute(const SubscriptionScreen());
      case Routes.helpScreen:
        return _pageRoute(const HelpScreen());
      case Routes.clientDetailsScreen:
        return _pageRoute(ClientDetailsScreen(
          client: arguments?['client'] as ClientModel? ??
              const ClientModel(
                id: '',
                name: '',
                phone: '',
                status: ClientStatus.newClient,
                source: ClientSource.qr,
              ),
        ));
      case Routes.myCardDetailsScreen:
        final card = arguments?['card'];
        if (card is MyCardModel) {
          return _pageRoute(MyCardDetailsScreen(card: card));
        }
        return _pageRoute(const _UndefinedScreen());
      case Routes.companySetup:
<<<<<<< HEAD
        return _pageRoute(const SetupScreen());
      case Routes.companySuccess:
        return _pageRoute(const SuccessScreen());
=======
        return _pageRoute(const CompanySetupScreen());
>>>>>>> 0ecc604e79f8296123f1d0d807b0097f196b95cd
      case Routes.companyDashboard:
        return _pageRoute(const DashboardScreen());
      case Routes.companyCards:
        return _pageRoute(const CardsScreen());
      case Routes.companyBrand:
        return _pageRoute(const BrandScreen());
      case Routes.companyCatalog:
        return _pageRoute(
          CatalogScreen(
            businessType: arguments?['businessType'] as CompanyBusinessType? ??
                CompanyBusinessType.restaurant,
            companyName: arguments?['companyName'] as String?,
            providerType: arguments?['providerType'] as String?,
            providerCity: arguments?['providerCity'] as String?,
            editable: arguments?['editable'] as bool? ?? true,
          ),
        );
      case Routes.companyCatalogItem:
        final item = arguments?['item'];
        final categories = arguments?['categories'];
        if (item is! CompanyCatalogItem ||
            categories is! List<CompanyCatalogCategory>) {
          return _pageRoute(const _UndefinedScreen());
        }
        return _pageRoute(
          CatalogItemScreen(
            item: item,
            categoryLabel: arguments?['categoryLabel'] as String? ?? '',
            categories: categories,
            providerName: arguments?['providerName'] as String?,
            providerType: arguments?['providerType'] as String?,
            providerCity: arguments?['providerCity'] as String?,
            editable: arguments?['editable'] as bool? ?? true,
          ),
        );
      case Routes.companyEmployees:
        return _pageRoute(const EmployeesScreen());
      case Routes.companyEmployeeDetails:
        final employee = arguments?['employee'];
        if (employee is! CompanyEmployeeItem) {
          return _pageRoute(const _UndefinedScreen());
        }
        return _pageRoute(EmployeeDetailsScreen(employee: employee));
      case Routes.companyEmployeeEdit:
        final employee = arguments?['employee'];
        if (employee is! CompanyEmployeeItem) {
          return _pageRoute(const _UndefinedScreen());
        }
        return _pageRoute(EmployeeEditScreen(employee: employee));
      case Routes.companyEmployeeDigital:
        final employee = arguments?['employee'];
        if (employee is! CompanyEmployeeItem) {
          return _pageRoute(const _UndefinedScreen());
        }
        return _pageRoute(
          EmployeeDigitalProfileScreen(employee: employee),
        );
      case Routes.companyEmployeeNfcLink:
        final employee = arguments?['employee'];
        if (employee is! CompanyEmployeeItem) {
          return _pageRoute(const _UndefinedScreen());
        }
        return _pageRoute(EmployeeNfcLinkScreen(employee: employee));
      case Routes.companyQr:
        return _pageRoute(const QrScreen());
      case Routes.companyPublish:
        return _pageRoute(const PublishScreen());
      case Routes.companyPublicPage:
        final data = arguments?['data'];
        return _pageRoute(
          PublicPageScreen(
            data: data is CompanyPublicPageData
                ? data
                : CompanyPublicPageData.sample,
          ),
        );
      case Routes.companyEdit:
<<<<<<< HEAD
        return _pageRoute(
          EditScreen(
            initialImagePath: arguments?['imagePath'] as String?,
          ),
        );
      case Routes.companyInvite:
        return _pageRoute(const InviteScreen());
      case Routes.companyNfc:
        return _pageRoute(const NfcScreen());
=======
        return _pageRoute(const CompanyEditScreen());
      case Routes.companySuccess:
        return _pageRoute(CompanySuccessScreen(
          companyName: arguments?['companyName'] as String? ?? '',
          industry: arguments?['industry'] as String? ?? '',
          subIndustry: arguments?['subIndustry'] as String? ?? '',
          size: arguments?['size'] as String? ?? '',
          city: arguments?['city'] as String? ?? '',
          phone: arguments?['phone'] as String? ?? '',
          email: arguments?['email'] as String? ?? '',
          website: arguments?['website'] as String? ?? '',
          bio: arguments?['bio'] as String? ?? '',
        ));
>>>>>>> 0ecc604e79f8296123f1d0d807b0097f196b95cd
      default:
        return _pageRoute(const _UndefinedScreen());
    }
  }

  static PageRoute<dynamic> _pageRoute(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}

class _UndefinedScreen extends StatelessWidget {
  const _UndefinedScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Page not found')),
    );
  }
}
