import 'package:flutterv1/shared/domain/entities/user.dart';

abstract class UserRepository {
  Future<User?> getUserById(String userId);
  Future<User?> getUserByUsername(String username);
  Future<List<User>> getAllUsers();
  Future<void> addUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String userId);
  // Future<void> clearUsers();
}
