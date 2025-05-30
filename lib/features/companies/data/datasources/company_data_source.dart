import 'package:flutterv1/features/companies/domain/entities/company.dart';

abstract class CompanyDataSource {
  Future<List<Company>> getAllCompanies();
  Future<Company> getCompanyById(String id);
  Future<Company> createCompany(Company company);
  Future<Company> updateCompany(Company company);
  Future<void> deleteCompany(String id);
}
