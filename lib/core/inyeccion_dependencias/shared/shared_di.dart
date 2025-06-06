import 'package:events_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:events_app/shared/data/mappers/user_mapper.dart';
import 'package:events_app/shared/domain/usecases/users/load_last_user.dart';
import 'package:get_it/get_it.dart';

import 'package:events_app/shared/data/datasources/local_credential_storage.dart';
import 'package:events_app/shared/data/datasources/credential_storage.dart';
import 'package:events_app/shared/data/datasources/local_session_data.dart';
import 'package:events_app/shared/data/repositories/session_repository_impl.dart';
import 'package:events_app/shared/domain/repositories/session_repository.dart';
import 'package:events_app/shared/domain/usecases/session/get_current_user.dart';
import 'package:events_app/shared/domain/usecases/session/change_session_status.dart';
import 'package:events_app/shared/domain/usecases/session/get_current_session_status.dart';
import 'package:events_app/shared/domain/usecases/session/get_current_session.dart';
import 'package:events_app/shared/domain/usecases/session/clear_session.dart';
import 'package:events_app/shared/presentation/providers/session_provider.dart';

import 'package:events_app/shared/data/datasources/users/local_user_datasource.dart';
import 'package:events_app/shared/data/datasources/users/user_datasource.dart';
import 'package:events_app/shared/data/repositories/user_repository_impl.dart';
import 'package:events_app/shared/domain/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initSharedModule(GetIt getIt) async {
  getIt.registerLazySingleton<LocalSessionData>(() => LocalSessionData());

  getIt.registerLazySingleton<UserDataSource>(() => LocalUserDatasource());
  getIt.registerLazySingleton<UserMapper>(() => UserMapperImpl());
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt<UserDataSource>(), getIt<UserMapper>()),
  );
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
    () async =>
        GetCurrentUser(getIt<SessionRepository>(), getIt<UserRepository>()),
    dependsOn: [SessionRepository],
  );
  getIt.registerSingletonAsync<ChangeSessionstatus>(
    () async => ChangeSessionstatus(getIt<SessionRepository>()),
    dependsOn: [SessionRepository],
  );
  getIt.registerSingletonAsync<GetCurrentSessionstatus>(
    () async => GetCurrentSessionstatus(getIt<SessionRepository>()),
    dependsOn: [SessionRepository],
  );
  getIt.registerSingletonAsync<GetCurrentSession>(
    () async => GetCurrentSession(getIt<SessionRepository>()),
    dependsOn: [SessionRepository],
  );
  getIt.registerSingletonAsync<ClearSession>(
    () async => ClearSession(getIt<SessionRepository>()),
    dependsOn: [SessionRepository],
  );
  getIt.registerSingletonAsync<LoadLastUser>(
    () async =>
        LoadLastUser(getIt<SessionRepository>(), getIt<AuthRepository>()),
    dependsOn: [SessionRepository],
  );

  getIt.registerSingletonAsync<SessionProvider>(
    () async => SessionProvider(
      getIt<GetCurrentUser>(),
      getIt<ChangeSessionstatus>(),
      getIt<GetCurrentSessionstatus>(),
      getIt<ClearSession>(),
      getIt<GetCurrentSession>(),
      getIt<LoadLastUser>(),
    ),
    dependsOn: [
      GetCurrentUser,
      ChangeSessionstatus,
      GetCurrentSessionstatus,
      ClearSession,
      GetCurrentSession,
      LoadLastUser,
    ],
  );
}
