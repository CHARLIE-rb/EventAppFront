import 'package:flutterv1/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutterv1/shared/data/mappers/user_mapper.dart';
import 'package:flutterv1/shared/domain/usecases/users/load_last_user.dart';
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

import 'package:flutterv1/shared/data/datasources/users/local_user_datasource.dart';
import 'package:flutterv1/shared/data/datasources/users/user_datasource.dart';
import 'package:flutterv1/shared/data/repositories/user_repository_impl.dart';
import 'package:flutterv1/shared/domain/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void initSharedModule(GetIt getIt) {
Future<void> initSharedModule(GetIt getIt) async {
  getIt.registerLazySingleton<LocalSessionData>(() => LocalSessionData());

  getIt.registerLazySingleton<UserDataSource>(() => LocalUserDatasource());
  getIt.registerLazySingleton<UserMapper>(() => UserMapperImpl());
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt<UserDataSource>(), getIt<UserMapper>()),
  );

  // getIt.registerSingletonAsync<CredentialStorage>(() async {
  //   final storage = LocalCredentialStorage();
  //   await storage.init();
  //   return storage;
  // });

  // getIt.registerSingletonAsync<CredentialStorage>(() async {
  //   return LocalCredentialStorage(await getIt.getAsync<SharedPreferences>());
  // }, dependsOn: [SharedPreferences]);

  // 2. CredentialStorage deja de ser async
  getIt.registerSingletonAsync<CredentialStorage>(
    () async => LocalCredentialStorage(await SharedPreferences.getInstance()),
  );

  getIt.registerSingletonAsync<SessionRepository>(
    () async => SessionRepositoryImpl(
      getIt<LocalSessionData>(),
      getIt<CredentialStorage>(),
    ),
    dependsOn: [CredentialStorage],
  );

  getIt.registerSingletonAsync<GetCurrentUser>(
    () async => GetCurrentUser(
      await getIt.getAsync<SessionRepository>(),
      getIt<UserRepository>(),
    ),
    dependsOn: [SessionRepository],
  );
  getIt.registerSingletonAsync<Logout>(
    () async => Logout(await getIt.getAsync<SessionRepository>()),
    dependsOn: [SessionRepository],
  );
  getIt.registerSingletonAsync<ChangeSessionstatus>(
    () async => ChangeSessionstatus(await getIt.getAsync<SessionRepository>()),
    dependsOn: [SessionRepository],
  );
  getIt.registerSingletonAsync<GetCurrentSessionstatus>(
    () async =>
        GetCurrentSessionstatus(await getIt.getAsync<SessionRepository>()),
    dependsOn: [SessionRepository],
  );
  getIt.registerSingletonAsync<GetCurrentSession>(
    () async => GetCurrentSession(await getIt.getAsync<SessionRepository>()),
    dependsOn: [SessionRepository],
  );
  getIt.registerSingletonAsync<ClearSession>(
    () async => ClearSession(await getIt.getAsync<SessionRepository>()),
    dependsOn: [SessionRepository],
  );
  getIt.registerSingletonAsync<LoadLastUser>(
    () async => LoadLastUser(
      await getIt.getAsync<SessionRepository>(),
      getIt<AuthRepository>(),
    ),
    dependsOn: [SessionRepository],
  );

  getIt.registerSingletonAsync<SessionProvider>(
    () async {
      // final sp = SessionProvider(
      return SessionProvider(
        await getIt.getAsync<GetCurrentUser>(),
        await getIt.getAsync<Logout>(),
        await getIt.getAsync<ChangeSessionstatus>(),
        await getIt.getAsync<GetCurrentSessionstatus>(),
        await getIt.getAsync<ClearSession>(),
        await getIt.getAsync<GetCurrentSession>(),
        await getIt.getAsync<LoadLastUser>(),
      );
      // await sp.initialize();
      // await sp.loadLastUser();
      // return sp;
    },
    dependsOn: [
      GetCurrentUser,
      Logout,
      ChangeSessionstatus,
      GetCurrentSessionstatus,
      ClearSession,
      GetCurrentSession,
      LoadLastUser,
    ],
  );
}
