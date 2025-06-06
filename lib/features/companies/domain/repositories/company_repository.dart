import 'package:events_app/features/companies/domain/entities/company.dart';

abstract class CompanyRepository {
  Future<List<Company>> getAllCompanies();
  Future<Company> getCompanyById(String id);
  Future<Company> createCompany(Company company);
  Future<Company> updateCompany(Company company);
  Future<void> deleteCompany(String id);
}
