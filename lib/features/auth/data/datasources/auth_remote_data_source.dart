import 'package:flutterv1/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutterv1/features/auth/domain/entities/user.dart';

class AuthRemoteDataSourceImpl implements AuthDataSource {
  @override
  Future<User> loginWithEmail(String email, String password) {
    // TODO: implement loginWithEmail
    throw UnimplementedError();
  }

  @override
  Future<User> loginWithPin(String id, String pin) {
    // TODO: implement loginWithPin
    throw UnimplementedError();
  }

  @override
  Future<User> register(User user) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
