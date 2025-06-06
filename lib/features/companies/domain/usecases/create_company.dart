import 'package:events_app/features/companies/domain/entities/company.dart';
import 'package:events_app/features/companies/domain/repositories/company_repository.dart';

class CreateCompany {
  final CompanyRepository repository;
  CreateCompany(this.repository);
  Future<Company> call(Company company) async {
    // This method will create a new company using the repository
    // and return the created company.
    return await repository.createCompany(company);
  }
}
