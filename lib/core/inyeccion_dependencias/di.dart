import 'package:flutterv1/core/inyeccion_dependencias/auth/auth_di.dart';
import 'package:flutterv1/core/inyeccion_dependencias/events/events_di.dart';
import 'package:flutterv1/features/companies/data/datasources/company_local_data_source.dart';
import 'package:flutterv1/features/companies/data/datasources/company_remote_datasource.dart';
import 'package:flutterv1/features/companies/domain/usecases/delete_company.dart';
import 'package:flutterv1/features/companies/domain/usecases/get_all_companies.dart';
import 'package:flutterv1/features/companies/domain/usecases/update_company.dart';
import 'package:flutterv1/features/companies/presentation/providers/companies_notifier.dart';
import 'package:flutterv1/features/events/data/datasources/event_data_source.dart';
import 'package:flutterv1/features/events/data/datasources/events_local_data_source.dart';
import 'package:flutterv1/features/events/data/mappers/event_mapper.dart';
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
  initAuthModule(getIt);
  initEventsModule(getIt);
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
