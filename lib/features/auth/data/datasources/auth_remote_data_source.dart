import 'package:flutterv1/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutterv1/shared/domain/entities/user.dart';

class AuthRemoteDataSourceImpl implements AuthDataSource {
  @override
  Future<bool> loginWithEmail(String email, String password) {
    // TODO: implement loginWithEmail
    throw UnimplementedError();
  }

  @override
  Future<bool> loginWithPin(String id, String pin) {
    // TODO: implement loginWithPin
    throw UnimplementedError();
  }

  @override
  Future<bool> register(User user) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
