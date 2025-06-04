// shared_di.dart

import 'package:get_it/get_it.dart';

import 'package:flutterv1/shared/data/datasources/local_credential_storage.dart';
import 'package:flutterv1/shared/data/datasources/credential_storage.dart';
import 'package:flutterv1/shared/data/datasources/local_session_data.dart';
import 'package:flutterv1/shared/data/repositories/session_repository_impl.dart';
import 'package:flutterv1/shared/domain/repositories/session_repository.dart';
import 'package:flutterv1/shared/domain/usecases/session/get_current_user.dart';
import 'package:flutterv1/shared/domain/usecases/session/logout.dart';
import 'package:flutterv1/shared/domain/usecases/session/change_session_status.dart';
import 'package:flutterv1/shared/domain/usecases/session/get_current_session_status.dart';
import 'package:flutterv1/shared/domain/usecases/session/get_current_session.dart';
import 'package:flutterv1/shared/domain/usecases/session/clear_session.dart';
import 'package:flutterv1/shared/presentation/providers/session_provider.dart';

import 'package:flutterv1/features/auth/data/mappers/user_mapper.dart';
import 'package:flutterv1/shared/data/datasources/users/local_user_datasource.dart';
import 'package:flutterv1/shared/data/datasources/users/user_datasource.dart';
import 'package:flutterv1/shared/data/repositories/user_repository_impl.dart';
import 'package:flutterv1/shared/domain/repositories/user_repository.dart';

/// Inicializa TODO lo relativo a “Shared” (CredentialStorage, SessionRepository,
/// casos de uso de sesión, SessionProvider y también UserRepository).
/// **No hay awaits aquí**: usamos registerSingletonWithDependencies + registerSingletonAsync.
/// El orden concreto se resolverá en main() con getIt.allReady().
void initSharedModule(GetIt getIt) {
  // 1) Registros SÍNCRONOS que NO dependen de nada asíncrono:
  getIt.registerLazySingleton<LocalSessionData>(() => LocalSessionData());

  getIt.registerLazySingleton<UserDataSource>(() => LocalUserDatasource());
  getIt.registerLazySingleton<UserMapper>(() => UserMapperImpl());
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt<UserDataSource>(), getIt<UserMapper>()),
  );

  // 2) CredentialStorage es un singleton ASÍNCRONO (p. ej. SharedPreferences.getInstance()):
  getIt.registerSingletonAsync<CredentialStorage>(() async {
    final storage = LocalCredentialStorage();
    await storage.init(); // inicialización interna (SharedPreferences, etc)
    return storage;
  });

  // 3) SessionRepository depende de CredentialStorage:
  //    sólo se creará cuando termine el Future de CredentialStorage.
  getIt.registerSingletonWithDependencies<SessionRepository>(
    () => SessionRepositoryImpl(
      getIt<LocalSessionData>(),
      getIt<CredentialStorage>(),
    ),
    dependsOn: [CredentialStorage],
  );

  // 4) Casos de uso de sesión (cada uno depende de SessionRepository):
  getIt.registerSingletonWithDependencies<GetCurrentUser>(
    () => GetCurrentUser(getIt<SessionRepository>(), getIt<UserRepository>()),
    // dependsOn: [SessionRepository],
  );
  getIt.registerSingletonWithDependencies<Logout>(
    () => Logout(getIt<SessionRepository>()),
    // dependsOn: [SessionRepository],
  );
  getIt.registerSingletonWithDependencies<ChangeSessionstatus>(
    () => ChangeSessionstatus(getIt<SessionRepository>()),
    // dependsOn: [SessionRepository],
  );
  getIt.registerSingletonWithDependencies<GetCurrentSessionstatus>(
    () => GetCurrentSessionstatus(getIt<SessionRepository>()),
    // dependsOn: [SessionRepository],
  );
  getIt.registerSingletonWithDependencies<GetCurrentSession>(
    () => GetCurrentSession(getIt<SessionRepository>()),
    // dependsOn: [SessionRepository],
  );
  getIt.registerSingletonWithDependencies<ClearSession>(
    () => ClearSession(getIt<SessionRepository>()),
    // dependsOn: [SessionRepository],
  );

  // 5) Finalmente, el SessionProvider (Factory) que inyecta todos los use‐cases:
  //    No necesita “dependsOn” directo, porque:
  //     - Todos los use‐cases ya están declarados como singletons
  //       con dependencias sobre SessionRepository.
  //     - Cuando alguien pida SessionProvider, GetIt ya habrá resuelto
  //       primero CredentialStorage → SessionRepository → use‐cases.
  // getIt.registerFactory<SessionProvider>(
  //   () => SessionProvider(
  //     getIt<GetCurrentUser>(),
  //     getIt<Logout>(),
  //     getIt<ChangeSessionstatus>(),
  //     getIt<GetCurrentSessionstatus>(),
  //     getIt<ClearSession>(),
  //     getIt<GetCurrentSession>(),
  //   ),
  // );
  getIt.registerSingletonAsync<SessionProvider>(
    () async => SessionProvider(
      getIt<GetCurrentUser>(),
      getIt<Logout>(),
      getIt<ChangeSessionstatus>(),
      getIt<GetCurrentSessionstatus>(),
      getIt<ClearSession>(),
      getIt<GetCurrentSession>(),
    ),
    dependsOn: [
      CredentialStorage,
      SessionRepository,
      GetCurrentUser,
      Logout,
      ChangeSessionstatus,
      GetCurrentSessionstatus,
      ClearSession,
      GetCurrentSession,
    ],
  );
}
