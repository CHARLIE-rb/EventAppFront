import 'package:flutter/material.dart';
import 'package:events_app/features/companies/data/datasources/company_data_source.dart';
import 'package:events_app/features/companies/domain/entities/company.dart';

class CompanyLocalDataSourceImpl implements CompanyDataSource {
  static final List<Company> _mockCompanies = [
    Company(
      id: 1,
      logo: Image.asset('assets/images/logoWilde.png'),
      name: 'Wilde & Partners',
      address: '123 Tech Street',
      phone: '555-1234',
      email: '',
    ),
  ];

  @override
  Future<List<Company>> getAllCompanies() async {
    // Simulate a delay for fetching data
    await Future.delayed(const Duration(seconds: 1));
    return _mockCompanies;
  }

  @override
  Future<void> deleteCompany(String companyId) async {
    // Simulate a delay for deleting a company
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<Company> updateCompany(Company company) async {
    // Simulate a delay for updating a company
    return await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<Company> createCompany(Company company) {
    // TODO: implement createCompany
    throw UnimplementedError();
  }

  @override
  Future<Company> getCompanyById(String id) {
    // TODO: implement getCompanyById
    throw UnimplementedError();
  }
}
