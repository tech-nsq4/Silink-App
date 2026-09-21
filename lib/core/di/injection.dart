import 'package:get_it/get_it.dart';

import '../../features/auth/data/auth_repo.dart';
import '../../features/auth/logic/auth_cubit.dart';
import '../../features/company/data/company_repo.dart';
import '../../features/company/logic/company_cubit.dart';
import '../../features/profile/logic/profile_cubit.dart';
import '../../features/profile_completion/data/profile_completion_repo.dart';
import '../../features/profile_completion/logic/profile_completion_cubit.dart';
import '../../features/store/data/order_repo.dart';
import '../../features/store/data/store_repo.dart';
import '../../features/store/logic/cart_cubit.dart';
import '../../features/store/logic/checkout_cubit.dart';
import '../../features/store/logic/store_cubit.dart';
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
  getIt.registerLazySingleton(() => StoreRepo(dio: getIt()));
  getIt.registerLazySingleton(() => OrderRepo(dio: getIt()));
  getIt.registerLazySingleton(() => CompanyRepo(dio: getIt()));
  getIt.registerLazySingleton(() => ProfileCompletionRepo(dio: getIt()));

  // ─── Cubits ────────────────────────────────────────────────────────────
  getIt.registerFactory(() => AuthCubit(getIt()));
  getIt.registerFactory(() => ProfileCubit(getIt()));
  getIt.registerFactory(() => ProfileCompletionCubit(getIt()));
  getIt.registerFactory(() => StoreCubit(getIt()));
  getIt.registerFactory(() => CartCubit());
  getIt.registerFactory(() => CheckoutCubit(getIt()));
  getIt.registerFactory(() => CompanyCubit(repo: getIt()));
}
