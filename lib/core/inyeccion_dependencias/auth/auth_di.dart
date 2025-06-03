// lib/core/inyeccion_dependencias/auth/auth_di.dart

import 'package:get_it/get_it.dart';

import 'package:flutterv1/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutterv1/features/auth/data/datasources/local/auth_local_data_source.dart';
import 'package:flutterv1/shared/data/datasources/credential_storage.dart';
import 'package:flutterv1/features/auth/data/datasources/local/local_credential_storage.dart';
import 'package:flutterv1/features/auth/data/mappers/user_mapper.dart';
import 'package:flutterv1/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutterv1/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutterv1/shared/domain/usecases/get_current_user.dart';
import 'package:flutterv1/features/auth/domain/usecases/login_with_email.dart';
import 'package:flutterv1/features/auth/domain/usecases/login_with_pin.dart';
import 'package:flutterv1/shared/domain/usecases/logout.dart';
import 'package:flutterv1/features/auth/domain/usecases/register_user.dart';
import 'package:flutterv1/features/auth/presentation/providers/auth_provider.dart';

void initAuthModule(GetIt getIt) {
  getIt.registerLazySingleton<UserMapper>(() => UserMapperImpl());
  // 1) DataSource: síncrono, no cambia
  getIt.registerLazySingleton<AuthDataSource>(
    () => AuthLocalDataSourceImpl(getIt<UserMapper>()),
  );

  // 2) CredentialStorage: ASÍNCRONO. GetIt esperará a que esto termine
  getIt.registerSingletonAsync<CredentialStorage>(() async {
    final storage = LocalCredentialStorage();
    await storage.init(); // <- aquí SharedPreferences.getInstance()
    return storage;
  });

  // 4) AuthRepository: también ASÍNCRONO, DEPENDE de CredentialStorage
  getIt.registerSingletonAsync<AuthRepository>(() async {
    final storage = await getIt.getAsync<CredentialStorage>();
    final repo = AuthRepositoryImpl(getIt<AuthDataSource>(), storage);
    await repo.loadCredentials(); // <- auto-login aquí
    return repo;
  }, dependsOn: [CredentialStorage]);

  // 5) Ahora que AuthRepository se marca “ready” solo tras ejecutar loadCredentials(),
  //    los use-cases pueden resolverse en caliente sin errores:
  getIt.registerLazySingleton<LoginWithEmail>(
    () => LoginWithEmail(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<LoginWithPin>(
    () => LoginWithPin(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<GetCurrentUser>(
    () => GetCurrentUser(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<RegisterUser>(
    () => RegisterUser(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<Logout>(() => Logout(getIt<AuthRepository>()));

  // 6) Finalmente, el AuthProvider puede pedir todos esos use-cases
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
