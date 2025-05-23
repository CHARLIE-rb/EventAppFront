import 'package:flutterv1/core/inyeccion_dependencias/auth/auth_di.dart';
import 'package:flutterv1/core/inyeccion_dependencias/events/events_di.dart';
import 'package:flutterv1/features/companies/data/datasources/company_local_data_source.dart';
import 'package:flutterv1/features/companies/data/datasources/company_remote_datasource.dart';
import 'package:flutterv1/features/companies/domain/usecases/delete_company.dart';
import 'package:flutterv1/features/companies/domain/usecases/get_all_companies.dart';
import 'package:flutterv1/features/companies/domain/usecases/update_company.dart';
import 'package:flutterv1/features/companies/presentation/providers/companies_notifier.dart';
import 'package:flutterv1/features/navigation/domain/usecases/get_nav_items.dart';
import 'package:flutterv1/features/navigation/presentation/providers/nav_notifier.dart';
import 'package:flutterv1/features/theme/presentation/providers/theme_provider.dart';
import 'package:get_it/get_it.dart';

// Providers
import 'package:flutterv1/features/auth/presentation/providers/auth_provider.dart';

// (Aquí podrías añadir repos, datasources, usecases, etc.)
final GetIt getIt = GetIt.instance;

void init() {
  getIt.registerFactory(() => ThemeProvider());

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
