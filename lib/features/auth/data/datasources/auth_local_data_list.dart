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
    eventsIds: ['e1', 'e2'],
    role: Role.employee,
  ),
  UserModel(
    id: 'u2',
    companyId: 1,
    name: 'Pedro',
    lastName: 'Lopez',
    email: 'pedro@ej.com',
    password: '123456',
    pin: '1111',
    eventsIds: ['e1', 'e2'],
    role: Role.manager,
  ),
];
