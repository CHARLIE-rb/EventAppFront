import 'package:flutterv1/features/auth/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> getUserById(String userId);
  Future<List<User>> getAllUsers();
  Future<void> addUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String userId);
  // Future<void> clearUsers();
}
