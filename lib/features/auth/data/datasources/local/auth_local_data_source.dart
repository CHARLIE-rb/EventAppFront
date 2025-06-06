import 'package:events_app/config/app_constants.dart';
import 'package:events_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:events_app/shared/data/datasources/users/users_local_data_list.dart';
import 'package:events_app/shared/data/models/user_model.dart';

class AuthLocalDataSourceImpl implements AuthDataSource {
  final List<UserModel> _mock = mockUserModel;

  AuthLocalDataSourceImpl();

  @override
  Future<bool> loginWithEmail(String email, String password) async {
    _mock.firstWhere(
      (u) => u.email == email && u.password == password,
      orElse: () => throw Exception(AppConstants.errorMessageLoginEmail),
    );
    return true;
  }

  @override
  Future<bool> loginWithPin(String mail, String pin) async {
    _mock.firstWhere(
      (u) => u.email == mail && u.pin == pin,
      orElse: () {
        throw Exception(AppConstants.errorMessagePinLogin);
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
