import 'package:flutterv1/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutterv1/shared/data/datasources/users/users_local_data_list.dart';
import 'package:flutterv1/shared/data/models/user_model.dart';

class AuthLocalDataSourceImpl implements AuthDataSource {
  final List<UserModel> _mock = mockUserModel;

  AuthLocalDataSourceImpl();

  @override
  Future<bool> loginWithEmail(String email, String password) async {
    _mock.firstWhere(
      (u) => u.email == email && u.password == password,
      orElse: () => throw Exception('Credenciales incorrectas'),
    );
    return true;
  }

  @override
  Future<bool> loginWithPin(String username, String pin) async {
    _mock.firstWhere(
      (u) => u.name == username && u.pin == pin,
      orElse: () {
        throw Exception('Credenciales incorrectas');
      },
    );
    return true;
  }

  @override
  Future<bool> register(UserModel user) async {
    _mock.add(user);
    return true;
  }
}
