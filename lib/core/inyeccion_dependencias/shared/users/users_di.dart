import 'package:events_app/shared/domain/repositories/user_repository.dart';
import 'package:events_app/shared/domain/usecases/users/create_user.dart';
import 'package:events_app/shared/domain/usecases/users/delete_user.dart';
import 'package:events_app/shared/domain/usecases/users/get_all_users.dart';
import 'package:events_app/shared/domain/usecases/users/get_user_by_email.dart';
import 'package:events_app/shared/domain/usecases/users/get_user_by_id.dart';
import 'package:events_app/shared/domain/usecases/users/get_users_by_ids.dart';
import 'package:events_app/shared/domain/usecases/users/update_user.dart';
import 'package:events_app/shared/presentation/providers/user_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:events_app/shared/data/datasources/users/local_user_datasource.dart';
import 'package:events_app/shared/data/datasources/users/user_datasource.dart';
import 'package:events_app/shared/data/mappers/user_mapper.dart';
import 'package:events_app/shared/data/repositories/user_repository_impl.dart';

Future<void> initSharedUsersModule(GetIt getIt) async {
  getIt.registerLazySingleton<UserDataSource>(() => LocalUserDatasource());
  getIt.registerLazySingleton<UserMapper>(() => UserMapperImpl());
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt<UserDataSource>(), getIt<UserMapper>()),
  );
  getIt.registerLazySingleton<CreateUser>(
    () => CreateUser(getIt<UserRepository>()),
  );
  getIt.registerLazySingleton<GetUserByEmail>(
    () => GetUserByEmail(getIt<UserRepository>()),
  );
  getIt.registerLazySingleton<GetAllUsers>(
    () => GetAllUsers(getIt<UserRepository>()),
  );
  getIt.registerLazySingleton<DeleteUser>(
    () => DeleteUser(getIt<UserRepository>()),
  );
  getIt.registerLazySingleton<GetUserById>(
    () => GetUserById(getIt<UserRepository>()),
  );
  getIt.registerLazySingleton<UpdateUser>(
    () => UpdateUser(getIt<UserRepository>()),
  );
  getIt.registerLazySingleton<GetUsersByIds>(
    () => GetUsersByIds(getIt<UserRepository>()),
  );
  getIt.registerFactory<UserProvider>(
    () => UserProvider(
      getIt<CreateUser>(),
      getIt<GetUserByEmail>(),
      getIt<GetAllUsers>(),
      getIt<DeleteUser>(),
      getIt<GetUserById>(),
      getIt<UpdateUser>(),
      getIt<GetUsersByIds>(),
    ),
  );
}
