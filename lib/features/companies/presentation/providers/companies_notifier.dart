import 'package:flutter/material.dart';
import 'package:events_app/features/companies/domain/entities/company.dart';
import 'package:events_app/features/companies/domain/usecases/delete_company.dart';
import 'package:events_app/features/companies/domain/usecases/get_all_companies.dart';
import 'package:events_app/features/companies/domain/usecases/update_company.dart';

class CompaniesNotifier extends ChangeNotifier {
  final GetAllCompanies _getAll;
  final DeleteCompany _delete;
  final UpdateCompany _update;
  List<Company> companies = [];
  bool isLoading = false;

  CompaniesNotifier(this._getAll, this._delete, this._update);

  Future<void> load() async {
    isLoading = true;
    notifyListeners();
    companies = await _getAll();
    isLoading = false;
    notifyListeners();
  }

  Future<void> delete(String companyId) async {
    await _delete(companyId);
    await load();
  }

  Future<void> update(Company company) async {
    await _update(company);
    await load();
  }
}
