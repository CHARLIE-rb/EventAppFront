// import 'package:flutterv1/features/auth/domain/entities/user.dart';

// final List<User> mockUsers = [
//   User(
//     id: 'u1',
//     companyId: 1,
//     name: 'Juan',
//     lastName: 'Pérez',
//     role: Role.employee,
//     email: 'juan.perez@example.com',
//     password: 'abc123',
//     pin: '111111',
//     registeredEventIds: ['e1', 'e2'],
//   ),
//   User(
//     id: 'u2',
//     companyId: 1,
//     name: 'María',
//     lastName: 'Gómez',
//     role: Role.manager,
//     email: 'maria.gomez@example.com',
//     password: 'xyz789',
//     pin: '222222',
//   ),
// ];

// class AuthService {
//   final List<User> _users = mockUsers;
//   User? _current = mockUsers.firstWhere((u) => u.id == 'u1');
//   // User? _current;
//   User? get currentUser => _current;

//   bool loginWithEmail(String email, String password) {
//     User? user;
//     try {
//       user = _users.firstWhere(
//         (u) => u.email == email && u.password == password,
//       );
//     } catch (e) {
//       user = null;
//     }
//     if (user != null) {
//       _current = user;
//       return true;
//     }
//     return false;
//   }

//   bool loginWithPin(String id, String pin) {
//     User? user;
//     try {
//       user = _users.firstWhere((u) => u.id == id && u.pin == pin);
//     } catch (e) {
//       user = null;
//     }
//     if (user != null) {
//       _current = user;
//       return true;
//     }
//     return false;
//   }

//   // Para registro en prueba (añade a la lista)
//   void register(User newUser) {
//     _users.add(newUser);
//   }

//   void logout() {
//     _current = null;
//   }
// }
