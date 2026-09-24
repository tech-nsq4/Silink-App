import 'package:get_it/get_it.dart';

import '../../features/auth/data/auth_repo.dart';
import '../../features/auth/logic/auth_cubit.dart';

import '../../features/company/company_profile_completion/data/company_profile_completion_repo.dart';
import '../../features/company/company_profile_completion/logic/company_profile_completion_cubit.dart';
import '../../features/profile/logic/profile_cubit.dart';
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

  // ─── Cubits ────────────────────────────────────────────────────────────
  getIt.registerFactory(() => AuthCubit(getIt()));
  getIt.registerFactory(() => ProfileCubit(getIt()));
  getIt.registerFactory(() => ProfileCompletionCubit(getIt()));
  getIt.registerFactory(() => CompanyProfileCompletionCubit(getIt()));

}
