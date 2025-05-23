// lib/features/auth/data/datasources/auth_local_data_source.dart

import 'package:flutterv1/features/auth/domain/entities/user.dart';

abstract class AuthLocalDataSource {
  Future<User> loginWithEmail(String email, String password);
  Future<User> loginWithPin(String id, String pin);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final _mock = <User>[
    User(
      id: 'u1',
      companyId: 1,
      name: 'Ana',
      lastName: 'Gonzalez',
      email: 'ana@ej.com',
      password: '1234',
      pin: '0000',
      role: Role.employee,
    ),
    User(
      id: 'u2',
      companyId: 1,
      name: 'Pedro',
      lastName: 'Lopez',
      email: 'pedro@ej.com',
      password: 'abcd',
      pin: '1111',
      role: Role.manager,
    ),
  ];

  @override
  Future<User> loginWithEmail(String email, String password) async {
    return _mock.firstWhere((u) => u.email == email && u.password == password);
  }

  @override
  Future<User> loginWithPin(String id, String pin) async {
    return _mock.firstWhere((u) => u.id == id && u.pin == pin);
  }
}
