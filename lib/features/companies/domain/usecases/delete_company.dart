import 'package:flutterv1/features/companies/domain/repositories/company_repository.dart';

class DeleteCompany {
  final CompanyRepository repository;

  DeleteCompany(this.repository);

  Future<void> call(String companyId) async {
    return await repository.deleteCompany(companyId);
  }
}
