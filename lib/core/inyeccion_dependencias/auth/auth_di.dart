// auth_di.dart

import 'package:flutterv1/shared/data/mappers/user_mapper.dart';
import 'package:get_it/get_it.dart';
import 'package:flutterv1/shared/domain/repositories/session_repository.dart';

import 'package:flutterv1/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutterv1/features/auth/data/datasources/local/auth_local_data_source.dart';
import 'package:flutterv1/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutterv1/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutterv1/features/auth/domain/usecases/login_with_email.dart';
import 'package:flutterv1/features/auth/domain/usecases/login_with_pin.dart';
import 'package:flutterv1/features/auth/domain/usecases/register_user.dart';
import 'package:flutterv1/features/auth/presentation/providers/auth_provider.dart';

void initAuthModule(GetIt getIt) {
  getIt.registerLazySingleton<AuthDataSource>(() => AuthLocalDataSourceImpl());
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthDataSource>(), getIt<UserMapper>()),
  );
  getIt.registerLazySingleton<RegisterUser>(
    () => RegisterUser(getIt<AuthRepository>()),
  );

  getIt.registerSingletonAsync<LoginWithEmail>(() async {
    return LoginWithEmail(
      getIt<AuthRepository>(),
      await getIt.getAsync<SessionRepository>(),
    );
  }, dependsOn: [SessionRepository]);

  getIt.registerSingletonAsync<LoginWithPin>(
    () async => LoginWithPin(
      getIt<AuthRepository>(),
      await getIt.getAsync<SessionRepository>(),
    ),
    dependsOn: [SessionRepository],
  );

  getIt.registerSingletonAsync<AuthProvider>(
    () async => AuthProvider(
      await getIt.getAsync<LoginWithEmail>(),
      await getIt.getAsync<LoginWithPin>(),
      getIt<RegisterUser>(),
    ),
    dependsOn: [LoginWithEmail, LoginWithPin],
  );
}
