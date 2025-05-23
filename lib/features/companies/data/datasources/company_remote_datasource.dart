import 'package:flutterv1/features/companies/domain/entities/company.dart';

abstract class CompanyRemoteDatasource {
  Future<List<Company>> getCompanies();
  Future<Company> getCompanyById(String id);
  Future<Company> createCompany(Company company);
  Future<Company> updateCompany(Company company);
  Future<void> deleteCompany(String id);
}

class CompanyRemoteDatasourceImpl implements CompanyRemoteDatasource {
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
  Future<List<Company>> getCompanies() {
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
