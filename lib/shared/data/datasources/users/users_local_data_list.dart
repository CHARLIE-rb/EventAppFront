import 'package:events_app/shared/domain/entities/user.dart';
import 'package:events_app/shared/data/models/user_model.dart';

final mockUserModel = <UserModel>[
  UserModel(
    id: 'u1',
    companyId: 1,
    name: 'Ana',
    lastName: 'Gonzalez',
    email: 'a',
    password: '123456',
    pin: '000000',
    eventsIds: ['e1', 'e2'],
    role: Role.employee.toString().replaceAll('Role.', ''),
  ),
  UserModel(
    id: 'u2',
    companyId: 1,
    name: 'Pedro',
    lastName: 'Lopez',
    email: 'b',
    password: '123456',
    pin: '111111',
    eventsIds: ['e1', 'e2'],
    role: Role.manager.toString().replaceAll('Role.', ''),
  ),
];
