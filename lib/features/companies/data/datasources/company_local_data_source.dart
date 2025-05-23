import 'package:flutter/material.dart';
import 'package:flutterv1/features/companies/domain/entities/company.dart';

abstract class CompanyLocalDataSource {
  Future<List<Company>> getAllCompanies();
  Future<void> deleteCompany(String companyId);
  Future<void> updateCompany(Company company);
}

class CompanyLocalDataSourceImpl implements CompanyLocalDataSource {
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
  Future<void> updateCompany(Company company) async {
    // Simulate a delay for updating a company
    await Future.delayed(const Duration(seconds: 1));
  }
}
