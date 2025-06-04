// auth_di.dart

import 'package:get_it/get_it.dart';
import 'package:flutterv1/shared/domain/repositories/session_repository.dart';

import 'package:flutterv1/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutterv1/features/auth/data/datasources/local/auth_local_data_source.dart';
import 'package:flutterv1/features/auth/data/mappers/user_mapper.dart';
import 'package:flutterv1/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutterv1/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutterv1/features/auth/domain/usecases/login_with_email.dart';
import 'package:flutterv1/features/auth/domain/usecases/login_with_pin.dart';
import 'package:flutterv1/features/auth/domain/usecases/register_user.dart';
import 'package:flutterv1/features/auth/presentation/providers/auth_provider.dart';

/// Inicializa TODO lo relativo a “Auth”.
/// Dado que LoginWithEmail y LoginWithPin dependen de SessionRepository,
/// los registramos con registerSingletonWithDependencies(..., dependsOn: [SessionRepository]).
void initAuthModule(GetIt getIt) {
  // 1) Registros sincrónicos que no dependen de SessionRepository:
  getIt.registerLazySingleton<AuthDataSource>(
    () => AuthLocalDataSourceImpl(getIt<UserMapper>()),
  );
  getIt.registerLazySingleton<UserMapper>(() => UserMapperImpl());
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthDataSource>()),
  );
  getIt.registerLazySingleton<RegisterUser>(
    () => RegisterUser(getIt<AuthRepository>()),
  );

  // 2) UseCases de Login que DEPENDEN de SessionRepository:
  //    Para crear estos usecases, GetIt esperará automáticamente a que
  //    SessionRepository (y, por transitividad, CredentialStorage) se complete.
  getIt.registerSingletonWithDependencies<LoginWithEmail>(
    () => LoginWithEmail(getIt<AuthRepository>(), getIt<SessionRepository>()),
    // dependsOn: [SessionRepository],
  );
  getIt.registerSingletonWithDependencies<LoginWithPin>(
    () => LoginWithPin(getIt<AuthRepository>(), getIt<SessionRepository>()),
    // dependsOn: [SessionRepository],
  );

  // 3) AuthProvider (Factory) que inyecta los tres usecases:
  //    (RegisterUser, LoginWithEmail, LoginWithPin).
  //    No hace falta dependsOn aquí porque:
  //      • RegisterUser se registró ya como LazySingleton sin dependencia alguna.
  //      • LoginWithEmail y LoginWithPin se registraron con dependsOn SessionRepository.
  //    Al pedir AuthProvider, GetIt ya se habrá asegurado de construir esos
  //    usecases antes de invocar el factory.
  getIt.registerFactory<AuthProvider>(
    () => AuthProvider(
      getIt<LoginWithEmail>(),
      getIt<LoginWithPin>(),
      getIt<RegisterUser>(),
    ),
  );
}
