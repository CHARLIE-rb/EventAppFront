import 'package:flutterv1/core/navigation/routes.dart';
import 'package:flutterv1/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutterv1/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:flutterv1/features/auth/data/mappers/user_mapper.dart';
import 'package:flutterv1/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutterv1/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutterv1/features/auth/domain/usecases/get_current_user.dart';
import 'package:flutterv1/features/auth/domain/usecases/login_with_email.dart';
import 'package:flutterv1/features/auth/domain/usecases/login_with_pin.dart';
import 'package:flutterv1/features/auth/domain/usecases/logout.dart';
import 'package:flutterv1/features/auth/domain/usecases/register_user.dart';
import 'package:flutterv1/features/auth/presentation/providers/auth_provider.dart';
import 'package:get_it/get_it.dart';

void initAuthModule(GetIt getIt) {
  // AUTH
  getIt.registerLazySingleton<AuthDataSource>(() => AuthLocalDataSourceImpl());

  getIt.registerLazySingleton<UserMapper>(() => UserMapperImpl());
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton(() => LoginWithEmail(getIt()));
  getIt.registerLazySingleton(() => LoginWithPin(getIt()));
  getIt.registerLazySingleton(() => GetCurrentUser(getIt()));
  getIt.registerLazySingleton(() => RegisterUser(getIt()));
  getIt.registerLazySingleton(() => Logout(getIt()));
  getIt.registerFactory(
    () => AuthProvider(getIt(), getIt(), getIt(), getIt(), getIt()),
  );
}
