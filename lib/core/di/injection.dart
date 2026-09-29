import 'package:get_it/get_it.dart';

import '../../features/auth/data/auth_repo.dart';
import '../../features/auth/logic/auth_cubit.dart';
import '../../features/cart/data/cart_repo.dart';
import '../../features/cart/logic/cart_cubit.dart';
import '../../features/checkout/data/checkout_repo.dart';
import '../../features/checkout/logic/checkout_cubit.dart';
import '../../features/faq/data/faq_repo.dart';
import '../../features/faq/logic/faq_cubit.dart';
import '../../features/checkout/logic/cities_cubit.dart';

import '../../features/company/company_profile_completion/data/company_profile_completion_repo.dart';
import '../../features/company/company_dashboard/logic/company_dashboard_cubit.dart';
import '../../features/company/employees/data/company_team_repo.dart';
import '../../features/company/employees/logic/company_team_cubit.dart';
import '../../features/company/employees/logic/company_team_member_cubit.dart';
import '../../features/company/company_profile_completion/logic/company_profile_completion_cubit.dart';
import '../../features/my_card/data/my_files_repo.dart';
import '../../features/my_card/logic/my_file_cubit.dart';
import '../../features/my_card/logic/my_files_cubit.dart';
import '../../features/orders/data/orders_repo.dart';
import '../../features/orders/logic/cancel_order_cubit.dart';
import '../../features/orders/logic/orders_cubit.dart';
import '../../features/profile/logic/profile_cubit.dart';
import '../../features/store/data/store_repo.dart';
import '../../features/store/logic/store_cubit.dart';
import '../../features/subscription/data/subscription_repo.dart';
import '../../features/subscription/logic/subscription_cubit.dart';
import '../../features/profile_card/data/profile_card_repo.dart';
import '../../features/profile_card/logic/profile_card_cubit.dart';
import '../../features/profile_completion/data/profile_completion_repo.dart';
import '../../features/profile_completion/logic/profile_completion_cubit.dart';

import '../network/dio_client.dart';
import '../storage/local_storage.dart';

final getIt = GetIt.instance;

Future<void> setupDi() async {
  // ─── Storage ──────────────────────────────────────────────────────────────
  getIt.registerLazySingleton(() => LocalStorage());

  // ─── Network ────────────────────────────────────────────────────────────
  getIt.registerLazySingleton(() => DioClient(storage: getIt()));

  // ─── Repos ────────────────────────────────────────────────────────────
  getIt.registerLazySingleton(() => AuthRepo(dio: getIt(), storage: getIt()));

  getIt.registerLazySingleton(() => ProfileCompletionRepo(dio: getIt()));
  getIt.registerLazySingleton(() => CompanyProfileCompletionRepo(dio: getIt()));
  getIt.registerLazySingleton(() => CompanyTeamRepo(dio: getIt()));
  getIt.registerLazySingleton(() => ProfileCardRepo(dio: getIt()));
  getIt.registerLazySingleton(() => MyFilesRepo(dio: getIt()));
  getIt.registerLazySingleton(() => CartRepo(storage: getIt()));
  getIt.registerLazySingleton(() => CheckoutRepo(dio: getIt()));
  getIt.registerLazySingleton(() => StoreRepo(dio: getIt()));
  getIt.registerLazySingleton(() => OrdersRepo(dio: getIt()));
  getIt.registerLazySingleton(() => SubscriptionRepo(dio: getIt()));
  getIt.registerLazySingleton(() => FaqRepo(dio: getIt()));

  // ─── Cubits ────────────────────────────────────────────────────────────
  getIt.registerFactory(() => AuthCubit(getIt()));
  getIt.registerFactory(() => ProfileCubit(getIt()));
  getIt.registerFactory(() => ProfileCompletionCubit(getIt()));
  getIt.registerFactory(() => CompanyProfileCompletionCubit(getIt()));
  getIt.registerFactory(() => CompanyDashboardCubit(getIt()));
  getIt.registerFactory(() => CompanyTeamCubit(getIt()));
  getIt.registerFactory(() => CompanyTeamMemberCubit(getIt()));
  getIt.registerFactory(() => ProfileCardCubit(getIt()));
  getIt.registerFactory(() => MyFilesCubit(getIt()));
  getIt.registerFactory(() => MyFileCubit(getIt()));
  getIt.registerFactory(() => CartCubit(getIt()));
  getIt.registerFactory(() => CheckoutCubit(getIt()));
  getIt.registerFactory(() => CitiesCubit(getIt()));
  getIt.registerFactory(() => StoreCubit(getIt()));
  getIt.registerFactory(() => OrdersCubit(getIt()));
  getIt.registerFactory(() => CancelOrderCubit(getIt()));
  getIt.registerFactory(() => SubscriptionCubit(getIt()));
  getIt.registerFactory(() => FaqCubit(getIt()));
}
