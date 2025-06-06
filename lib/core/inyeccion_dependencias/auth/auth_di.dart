// auth_di.dart

import 'package:events_app/shared/data/mappers/user_mapper.dart';
import 'package:get_it/get_it.dart';
import 'package:events_app/shared/domain/repositories/session_repository.dart';

import 'package:events_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:events_app/features/auth/data/datasources/local/auth_local_data_source.dart';
import 'package:events_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:events_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:events_app/features/auth/domain/usecases/login_with_email.dart';
import 'package:events_app/features/auth/domain/usecases/login_with_pin.dart';
import 'package:events_app/features/auth/domain/usecases/register_user.dart';
import 'package:events_app/features/auth/presentation/providers/auth_provider.dart';

Future<void> initAuthModule(GetIt getIt) async {
  getIt.registerLazySingleton<AuthDataSource>(() => AuthLocalDataSourceImpl());
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthDataSource>(), getIt<UserMapper>()),
  );
  getIt.registerLazySingleton<RegisterUser>(
    () => RegisterUser(getIt<AuthRepository>()),
  );

  getIt.registerSingletonAsync<LoginWithEmail>(() async {
    return LoginWithEmail(getIt<AuthRepository>(), getIt<SessionRepository>());
  }, dependsOn: [SessionRepository]);

  getIt.registerSingletonAsync<LoginWithPin>(
    () async =>
        LoginWithPin(getIt<AuthRepository>(), getIt<SessionRepository>()),
    dependsOn: [SessionRepository],
  );

  getIt.registerSingletonAsync<AuthProvider>(
    () async => AuthProvider(
      getIt<LoginWithEmail>(),
      getIt<LoginWithPin>(),
      getIt<RegisterUser>(),
    ),
    dependsOn: [LoginWithEmail, LoginWithPin],
  );
}
