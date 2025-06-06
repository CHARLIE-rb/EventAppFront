import 'package:events_app/features/companies/data/datasources/company_data_source.dart';
import 'package:events_app/features/companies/data/datasources/company_local_data_source.dart';
import 'package:events_app/features/companies/data/repositories/company_repository_impl.dart';
import 'package:events_app/features/companies/domain/repositories/company_repository.dart';
import 'package:events_app/features/companies/domain/usecases/delete_company.dart';
import 'package:events_app/features/companies/domain/usecases/get_all_companies.dart';
import 'package:events_app/features/companies/domain/usecases/update_company.dart';
import 'package:events_app/features/companies/presentation/providers/companies_notifier.dart';
import 'package:get_it/get_it.dart';

Future<void> initCompaniesModule(GetIt getIt) async {
  getIt.registerLazySingleton<CompanyDataSource>(
    () => CompanyLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<CompanyRepository>(
    () => CompanyRepositoryImpl(getIt<CompanyDataSource>()),
  );
  getIt.registerSingletonWithDependencies<GetAllCompanies>(
    () => GetAllCompanies(getIt<CompanyRepository>()),
    // dependsOn: [CompanyRepository],
  );
  getIt.registerSingletonWithDependencies<DeleteCompany>(
    () => DeleteCompany(getIt<CompanyRepository>()),
    // dependsOn: [CompanyRepository],
  );
  getIt.registerSingletonWithDependencies<UpdateCompany>(
    () => UpdateCompany(getIt<CompanyRepository>()),
    // dependsOn: [CompanyRepository],
  );
  getIt.registerFactory<CompaniesNotifier>(
    () => CompaniesNotifier(
      getIt<GetAllCompanies>(),
      getIt<DeleteCompany>(),
      getIt<UpdateCompany>(),
    ),
  );
}
