import 'package:events_app/features/companies/domain/entities/company.dart';
import 'package:events_app/features/companies/domain/repositories/company_repository.dart';

class UpdateCompany {
  final CompanyRepository repository;

  UpdateCompany(this.repository);

  Future<Company> call(Company company) async {
    return await repository.updateCompany(company);
  }
}
