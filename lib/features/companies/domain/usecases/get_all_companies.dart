import 'package:flutterv1/features/companies/domain/entities/company.dart';
import 'package:flutterv1/features/companies/domain/repositories/company_repository.dart';

class GetAllCompanies {
  // This class will contain the logic to fetch all companies
  // from the repository and return them to the presentation layer.
  // It will use the repository interface to get the data.
  // The repository will handle the data source (API, local database, etc.)
  // and return the data to this use case.

  final CompanyRepository repository;

  GetAllCompanies(this.repository);

  Future<List<Company>> call() async {
    return await repository.getAllCompanies();
  }
}
