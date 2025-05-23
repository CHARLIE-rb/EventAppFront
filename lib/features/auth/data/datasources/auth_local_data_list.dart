import 'package:flutterv1/features/auth/data/models/user_model.dart';
import 'package:flutterv1/features/auth/domain/entities/user.dart';

final mockUserModel = <UserModel>[
  UserModel(
    id: 'u1',
    companyId: 1,
    name: 'Ana',
    lastName: 'Gonzalez',
    email: 'ana@ej.com',
    password: '1234',
    pin: '0000',
    role: Role.employee,
  ),
  UserModel(
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
