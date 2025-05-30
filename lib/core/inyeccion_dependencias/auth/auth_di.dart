// lib/core/inyeccion_dependencias/auth_di.dart

import 'package:get_it/get_it.dart';

import 'package:flutterv1/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutterv1/features/auth/data/datasources/local/auth_local_data_source.dart';
import 'package:flutterv1/features/auth/data/datasources/credential_storage.dart';
import 'package:flutterv1/features/auth/data/datasources/local/local_credential_storage.dart';
import 'package:flutterv1/features/auth/data/mappers/user_mapper.dart';
import 'package:flutterv1/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutterv1/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutterv1/features/auth/domain/usecases/get_current_user.dart';
import 'package:flutterv1/features/auth/domain/usecases/login_with_email.dart';
import 'package:flutterv1/features/auth/domain/usecases/login_with_pin.dart';
import 'package:flutterv1/features/auth/domain/usecases/logout.dart';
import 'package:flutterv1/features/auth/domain/usecases/register_user.dart';
import 'package:flutterv1/features/auth/presentation/providers/auth_provider.dart';

void initAuthModule(GetIt getIt) {
  getIt.registerLazySingleton<AuthDataSource>(() => AuthLocalDataSourceImpl());

  getIt.registerSingletonAsync<CredentialStorage>(() async {
    final storage = LocalCredentialStorage();
    await storage.init();
    return storage;
  });

  getIt.registerLazySingleton<UserMapper>(() => UserMapperImpl());

  getIt.registerSingletonAsync<AuthRepository>(() async {
    final storage = await getIt.getAsync<CredentialStorage>();
    final repo = AuthRepositoryImpl(
      getIt<AuthDataSource>(),
      getIt<UserMapper>(),
      storage,
    );
    await repo.loadCredentials();
    return repo;
  }, dependsOn: [CredentialStorage]);

  getIt.registerLazySingleton(() => LoginWithEmail(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => LoginWithPin(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => GetCurrentUser(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => RegisterUser(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => Logout(getIt<AuthRepository>()));

  getIt.registerFactory<AuthProvider>(
    () => AuthProvider(
      getIt<LoginWithEmail>(),
      getIt<LoginWithPin>(),
      getIt<GetCurrentUser>(),
      getIt<RegisterUser>(),
      getIt<Logout>(),
    ),
  );
}
