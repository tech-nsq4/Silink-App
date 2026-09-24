import 'package:Silink/app/router/routes.dart';
import 'package:Silink/features/auth/data/models/user_model.dart';

class AppConstants {
  AppConstants._();

  // ─── App ──────────────────────────────────────────────────────────────────
  static const String appName = 'Silink';

  // ─── Pagination ───────────────────────────────────────────────────────────
  static const int pageSize = 15;
  static const int firstPage = 1;

  // ─── Animation ────────────────────────────────────────────────────────────
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration shortAnimationDuration = Duration(milliseconds: 150);

  // ─── UI ───────────────────────────────────────────────────────────────────
  static const double defaultBorderRadius = 12.0;
  static const double cardBorderRadius = 16.0;
  static const double buttonBorderRadius = 12.0;
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;

  static const int storeGridColumns = 2;
  static const double productGridAspectRatio = 0.68;
  static const int catalogGridColumns = 2;
  static const double catalogGridAspectRatio = 0.80;
  static const double defaultShippingCost = 25.0;
  static const double defaultFreeShippingThreshold = 300.0;

  static const String companyPageHost = 'silink.nsq4.sa/c/';
  static const String companyPageUrl = 'https://$companyPageHost';
}

class AppFonts {
  static const String familyFont = 'Cairo';
}

/// The currently authenticated user. `null` means the user is browsing as a guest.
UserModel? kUserModel;

/// Returns `true` when the user is NOT logged in (guest mode).
/// Use this everywhere in the app to guard authenticated-only actions.
bool get kIsGuest => kUserModel == null;

/// The home route to land the current user on right after auth/splash,
/// based on their account type.
String get kHomeRoute => kUserModel?.usageIntent == 'company'
    ? Routes.companyDashboard
    : Routes.layoutScreen;
