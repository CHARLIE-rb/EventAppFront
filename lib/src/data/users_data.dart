// Lista hardcodeada para pruebas
import 'package:flutterv1/src/models/role.dart';
import 'package:flutterv1/src/models/user.dart';

final List<User> mockUsers = [
  User(
    id: 'u1',
    name: 'Juan',
    lastName: 'Pérez',
    role: Role.employee,
    email: 'juan.perez@example.com',
    password: 'abc123',
    pin: '111111',
    registeredEventIds: ['e1', 'e2'],
  ),
  User(
    id: 'u2',
    name: 'María',
    lastName: 'Gómez',
    role: Role.manager,
    email: 'maria.gomez@example.com',
    password: 'xyz789',
    pin: '222222',
  ),
];
