import 'package:Silink/features/card_studio/data/models/studio_draft.dart';
import 'package:Silink/features/card_studio/presentation/card_studio_screen.dart';
import 'package:Silink/features/card_assistant/presentation/card_assistant_screen.dart';
import 'package:Silink/features/auth/presentation/new_card_start_screen.dart';
import 'package:Silink/features/account/presentation/account_edit_screen.dart';
import 'package:Silink/features/account/presentation/account_guest_screen.dart';
import 'package:Silink/features/account/presentation/account_screen.dart';
import 'package:Silink/features/auth/data/models/user_model.dart';
import 'package:Silink/features/account/presentation/change_password_screen.dart';
import 'package:Silink/features/clients/data/models/client_category_model.dart';
import 'package:Silink/features/clients/data/models/client_model.dart';
import 'package:Silink/features/clients/presentation/client_details_screen.dart';
import 'package:Silink/features/clients/presentation/client_form_screen.dart';

import 'package:Silink/features/company/catalog/presentation/catalog_item_screen.dart';
import 'package:Silink/features/company/catalog/presentation/catalog_screen.dart';
import 'package:Silink/features/company/catalog/presentation/catalog_item_form_screen.dart';
import 'package:Silink/features/company/catalog/logic/company_catalog_cubit.dart';
import 'package:Silink/features/profile_completion/data/models/catalog_model.dart';
import 'package:Silink/features/company/data/models/company_business_type.dart';
import 'package:Silink/features/company/data/models/company_catalog_item.dart';
import 'package:Silink/features/company/employees/data/models/company_employee_model.dart';
import 'package:Silink/features/company/data/models/company_public_page_data.dart';
import 'package:Silink/features/company/employees/presentation/employee_details_screen.dart';
import 'package:Silink/features/company/employees/presentation/employee_digital_profile_screen.dart';
import 'package:Silink/features/company/employees/presentation/employee_edit_screen.dart';
import 'package:Silink/features/company/employees/presentation/employee_invite_screen.dart';
import 'package:Silink/features/company/employees/presentation/employee_nfc_link_screen.dart';

import 'package:Silink/features/company/employees/presentation/employees_screen.dart';
import 'package:Silink/features/nfc/presentation/nfc_screen.dart';

import 'package:Silink/features/help/presentation/help_screen.dart';
import 'package:Silink/features/notifications/presentation/notifications_screen.dart';
import 'package:Silink/features/settings/data/models/static_page_content.dart';
import 'package:Silink/features/settings/presentation/settings_screen.dart';
import 'package:Silink/features/settings/presentation/static_page_screen.dart';
import 'package:Silink/features/profile_completion/data/models/profile_completion_data.dart';
import 'package:Silink/features/profile_card/presentation/profile_card_screen.dart';
import 'package:Silink/features/my_card/models/my_card_model.dart';
import 'package:Silink/features/my_card/presentation/my_card_details_screen.dart';
import 'package:Silink/features/my_card/presentation/public_profile_preview_screen.dart';
import 'package:Silink/features/my_card/presentation/published_screen.dart';
import 'package:Silink/features/my_card/presentation/qr_code_screen.dart';
import 'package:Silink/features/auth/presentation/usage_type_screen.dart';
import 'package:Silink/features/services/presentation/service_details_screen.dart';
import 'package:Silink/features/statistics/presentation/statistics_screen.dart';
import 'package:Silink/features/checkout/data/models/order_model.dart';
import 'package:Silink/features/checkout/presentation/order_success_screen.dart';
import 'package:Silink/features/checkout/presentation/order_flow_screen.dart';
import 'package:Silink/features/orders/data/models/my_order_model.dart';
import 'package:Silink/features/orders/presentation/my_orders_screen.dart';
import 'package:Silink/features/orders/presentation/order_details_screen.dart';
import 'package:Silink/features/store/data/models/product.dart';
import 'package:Silink/features/store/presentation/card_customization_screen.dart';
import 'package:Silink/features/store/presentation/category_products_screen.dart';
import 'package:Silink/features/store/presentation/product_details_screen.dart';
import 'package:Silink/features/store/presentation/store_screen.dart';
import 'package:Silink/features/subscription/presentation/subscription_screen.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/auth_screen.dart';
import '../../features/auth/presentation/otp_screen.dart';
import '../../features/company/company_card/presentation/brand_screen.dart';
import '../../features/company/company_card/presentation/cards_screen.dart';

import '../../features/company/company_dashboard/presentation/dashboard_screen.dart';
import '../../features/company/company_profile_completion/presentation/company_edit_screen.dart';
import '../../features/company/company_card/presentation/public_page_screen.dart';
import '../../features/company/company_card/presentation/publish_screen.dart';
import '../../features/company/company_card/presentation/qr_screen.dart';
import '../../features/company/company_profile_completion/presentation/company_workspace_screen.dart';
import '../../features/company/company_card/presentation/success_screen.dart';

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
        return _pageRoute(const AuthScreen());

      case Routes.registerScreen:
        return _pageRoute(const AuthScreen(startWithRegister: true));

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
      case Routes.newCardStartScreen:
        return _pageRoute(NewCardStartScreen(
          usageIntent: arguments?['usageIntent'] as String? ?? 'personal',
        ));
      case Routes.cardAssistantScreen:
        return _pageRoute(CardAssistantScreen(
          usageIntent: arguments?['usageIntent'] as String? ?? 'personal',
        ));
      case Routes.profileCompletionScreen:
        return _pageRoute(const CardStudioScreen(remote: true));
      case Routes.cardStudioScreen:
        return _pageRoute(CardStudioScreen(
          remote: arguments?['remote'] as bool? ?? false,
          resume: arguments?['resume'] as bool? ?? false,
          initialDraft: arguments?['draft'] as StudioDraft?,
        ));
      case Routes.profileCardScreen:
        return _pageRoute(ProfileCardScreen(
          viewOnly: arguments?['viewOnly'] as bool? ?? false,
          fromStudio: arguments?['fromStudio'] as bool? ?? false,
        ));
      case Routes.statisticsScreen:
        return _pageRoute(const StatisticsScreen());
      case Routes.storeScreen:
        return _pageRoute(const StoreScreen(), settings: settings);
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
        final product = arguments?['product'] as Product?;
        if (product == null) return _pageRoute(const _UndefinedScreen());
        return _pageRoute(ProductDetailsScreen(product: product));
      case Routes.categoryProductsScreen:
        return _pageRoute(CategoryProductsScreen(
          products: arguments?['products'] as List<Product>? ?? const [],
          category: arguments?['category'] as ProductCategory?,
        ));
      case Routes.cardCustomizationScreen:
        final product = arguments?['product'] as Product?;
        if (product == null) return _pageRoute(const _UndefinedScreen());
        return _pageRoute(CardCustomizationScreen(product: product));
      case Routes.cartScreen:
        return _pageRoute(const OrderFlowScreen());
      case Routes.checkoutScreen:
        return _pageRoute(const OrderFlowScreen(initialStep: 1));
      case Routes.paymentScreen:
        return _pageRoute(const OrderFlowScreen(initialStep: 1));
      case Routes.orderSuccessScreen:
        final order = arguments?['order'] as OrderModel?;
        if (order == null) return _pageRoute(const _UndefinedScreen());
        return _pageRoute(OrderSuccessScreen(order: order));
      case Routes.myOrdersScreen:
        return _pageRoute(const MyOrdersScreen());
      case Routes.orderDetailsScreen:
        final myOrder = arguments?['order'] as MyOrderModel?;
        if (myOrder == null) return _pageRoute(const _UndefinedScreen());
        return _pageRoute(OrderDetailsScreen(order: myOrder));
      case Routes.accountGuestScreen:
        return _pageRoute(const AccountGuestScreen());
      case Routes.accountScreen:
        return _pageRoute(const AccountScreen());
      case Routes.changePasswordScreen:
        return _pageRoute(const ChangePasswordScreen());
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
      case Routes.settingsScreen:
        return _pageRoute(const SettingsScreen());
      case Routes.staticPageScreen:
        return _pageRoute(StaticPageScreen(
          type: arguments?['type'] as StaticPageType? ??
              StaticPageType.privacySecurity,
        ));
      case Routes.subscriptionScreen:
        return _pageRoute(const SubscriptionScreen());
      case Routes.helpScreen:
        return _pageRoute(const HelpScreen());
      case Routes.clientDetailsScreen:
        final client = arguments?['client'];
        if (client is! ClientModel) return _pageRoute(const _UndefinedScreen());
        return _pageRoute(ClientDetailsScreen(client: client));
      case Routes.clientFormScreen:
        return _pageRoute(ClientFormScreen(
          client: arguments?['client'] as ClientModel?,
          categories: arguments?['categories'] as List<ClientCategoryModel>? ??
              const [],
        ));
      case Routes.myCardDetailsScreen:
        final card = arguments?['card'];
        if (card is MyCardModel) {
          return _pageRoute(MyCardDetailsScreen(card: card));
        }
        return _pageRoute(const _UndefinedScreen());
      case Routes.companySetup:
        return _pageRoute(const CompanyWorkspaceScreen());
      case Routes.companySuccess:
        return _pageRoute(const SuccessScreen());
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
      case Routes.companyProducts:
        return _pageRoute(const CatalogScreen());
      case Routes.companyCatalogForm:
        return _pageRoute(CatalogItemFormScreen(
          kind: arguments?['kind'] as String? ?? CompanyCatalogCubit.itemKind,
          item: arguments?['item'] as CatalogItemModel?,
          actionTypes:
              arguments?['actionTypes'] as List<CatalogActionType>? ?? const [],
          section: arguments?['section'] as String? ?? '',
          sectionOptions:
              arguments?['sectionOptions'] as List<String>? ?? const [],
        ));
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
        if (employee is! CompanyEmployeeModel) {
          return _pageRoute(const _UndefinedScreen());
        }
        return _pageRoute(EmployeeDetailsScreen(employee: employee));
      case Routes.companyEmployeeEdit:
        final employee = arguments?['employee'];
        if (employee is! CompanyEmployeeModel) {
          return _pageRoute(const _UndefinedScreen());
        }
        return _pageRoute(EmployeeEditScreen(employee: employee));
      case Routes.companyEmployeeDigital:
        final employee = arguments?['employee'];
        if (employee is! CompanyEmployeeModel) {
          return _pageRoute(const _UndefinedScreen());
        }
        return _pageRoute(
          EmployeeDigitalProfileScreen(employee: employee),
        );
      case Routes.companyEmployeeNfcLink:
        final employee = arguments?['employee'];
        if (employee is! CompanyEmployeeModel) {
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
        return _pageRoute(const CompanyEditScreen());
      case Routes.companyInvite:
        return _pageRoute(const EmployeeInviteScreen());
      case Routes.companyNfc:
        return _pageRoute(const NfcScreen());
      default:
        return _pageRoute(const _UndefinedScreen());
    }
  }

  static PageRoute<dynamic> _pageRoute(Widget page, {RouteSettings? settings}) {
    return MaterialPageRoute(builder: (_) => page, settings: settings);
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
