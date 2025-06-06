import 'package:events_app/features/companies/data/datasources/company_data_source.dart';
import 'package:events_app/features/companies/domain/entities/company.dart';

class CompanyRemoteDatasourceImpl implements CompanyDataSource {
  @override
  Future<Company> createCompany(Company company) {
    // TODO: implement createCompany
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCompany(String id) {
    // TODO: implement deleteCompany
    throw UnimplementedError();
  }

  @override
  Future<List<Company>> getAllCompanies() {
    // TODO: implement getCompanies
    throw UnimplementedError();
  }

  @override
  Future<Company> getCompanyById(String id) {
    // TODO: implement getCompanyById
    throw UnimplementedError();
  }

  @override
  Future<Company> updateCompany(Company company) {
    // TODO: implement updateCompany
    throw UnimplementedError();
  }
}
