import 'package:Silink/features/account/presentation/account_edit_screen.dart';
import 'package:Silink/features/account/presentation/account_guest_screen.dart';
import 'package:Silink/features/account/presentation/account_screen.dart';
import 'package:Silink/features/auth/data/models/user_model.dart';
import 'package:Silink/features/company/presentation/company_brand_screen.dart';
import 'package:Silink/features/company/presentation/company_cards_screen.dart';
import 'package:Silink/features/company/presentation/company_catalog_screen.dart';
import 'package:Silink/features/company/presentation/company_dashboard_screen.dart';
import 'package:Silink/features/company/presentation/company_edit_screen.dart';
import 'package:Silink/features/company/presentation/company_employees_screen.dart';
import 'package:Silink/features/company/presentation/company_publish_screen.dart';
import 'package:Silink/features/company/presentation/company_qr_screen.dart';
import 'package:Silink/features/company/presentation/company_setup_screen.dart';
import 'package:Silink/features/company/presentation/company_success_screen.dart';
import 'package:Silink/features/profile_completion/models/profile_completion_data.dart';
import 'package:Silink/features/profile_completion/presentation/profile_completion_screen.dart';
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
          user: arguments?['user'] as UserModel? ?? UserModel(
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
      case Routes.companySetup:
        return _pageRoute(const CompanySetupScreen());
      case Routes.companySuccess:
        return _pageRoute(const CompanySuccessScreen());
      case Routes.companyDashboard:
        return _pageRoute(const CompanyDashboardScreen());
      case Routes.companyCards:
        return _pageRoute(const CompanyCardsScreen());
      case Routes.companyBrand:
        return _pageRoute(const CompanyBrandScreen());
      case Routes.companyCatalog:
        return _pageRoute(const CompanyCatalogScreen());
      case Routes.companyEmployees:
        return _pageRoute(const CompanyEmployeesScreen());
      case Routes.companyQr:
        return _pageRoute(const CompanyQrScreen());
      case Routes.companyPublish:
        return _pageRoute(const CompanyPublishScreen());
      case Routes.companyEdit:
        return _pageRoute(const CompanyEditScreen());
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
