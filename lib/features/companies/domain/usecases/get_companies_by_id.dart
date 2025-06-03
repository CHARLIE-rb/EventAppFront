import 'package:flutterv1/features/companies/domain/entities/company.dart';
import 'package:flutterv1/features/companies/domain/repositories/company_repository.dart';

class GetCompaniesById {
  final CompanyRepository repository;

  GetCompaniesById(this.repository);

  Future<Company> call(String id) async {
    return await repository.getCompanyById(id);
  }
}
