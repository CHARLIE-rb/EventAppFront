import 'package:flutterv1/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutterv1/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:flutterv1/features/auth/data/mappers/user_mapper.dart';
import 'package:flutterv1/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutterv1/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutterv1/features/auth/domain/usecases/get_current_user.dart';
import 'package:flutterv1/features/auth/domain/usecases/login_with_email.dart';
import 'package:flutterv1/features/auth/domain/usecases/login_with_pin.dart';
import 'package:flutterv1/features/auth/domain/usecases/logout.dart';
import 'package:flutterv1/features/auth/domain/usecases/register_user.dart';
import 'package:flutterv1/features/companies/data/datasources/company_local_data_source.dart';
import 'package:flutterv1/features/companies/data/datasources/company_remote_datasource.dart';
import 'package:flutterv1/features/companies/domain/usecases/delete_company.dart';
import 'package:flutterv1/features/companies/domain/usecases/get_all_companies.dart';
import 'package:flutterv1/features/companies/domain/usecases/update_company.dart';
import 'package:flutterv1/features/companies/presentation/providers/companies_notifier.dart';
import 'package:flutterv1/features/events/data/datasources/event_remote_data_source.dart';
import 'package:flutterv1/features/events/data/datasources/events_local_data_source.dart';
import 'package:flutterv1/features/events/data/repositories/event_repository_impl.dart';
import 'package:flutterv1/features/events/domain/repositories/event_repository.dart';
import 'package:flutterv1/features/events/domain/usecases/get_all_events.dart';
import 'package:flutterv1/features/events/domain/usecases/get_event_by_id.dart';
import 'package:flutterv1/features/events/presentation/providers/events_notifier.dart';
import 'package:flutterv1/features/navigation/domain/usecases/get_nav_items.dart';
import 'package:flutterv1/features/navigation/presentation/providers/nav_notifier.dart';
import 'package:get_it/get_it.dart';

// Providers
import 'package:flutterv1/features/auth/presentation/providers/auth_provider.dart';

// (Aquí podrías añadir repos, datasources, usecases, etc.)
final GetIt getIt = GetIt.instance;

void init() {
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

  // EVENTS
  getIt.registerLazySingleton<EventRemoteDataSource>(
    () => EventRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<EventLocalDataSource>(
    () => EventLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton(() => GetAllEvents(getIt()));
  getIt.registerLazySingleton(() => GetEventById(getIt()));
  getIt.registerFactory(() => EventsNotifier(getIt()));

  // NAVIGATION
  getIt.registerLazySingleton(() => GetNavItems());
  getIt.registerFactory(() => NavNotifier(getIt(), getIt<AuthProvider>()));

  // COMPANIES
  getIt.registerLazySingleton<CompanyLocalDataSource>(
    () => CompanyLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<CompanyRemoteDatasource>(
    () => CompanyRemoteDatasourceImpl(),
  );
  getIt.registerLazySingleton(() => GetAllCompanies(getIt()));
  getIt.registerLazySingleton(() => DeleteCompany(getIt()));
  getIt.registerLazySingleton(() => UpdateCompany(getIt()));
  getIt.registerFactory(() => CompaniesNotifier(getIt(), getIt(), getIt()));
}
