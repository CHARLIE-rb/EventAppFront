import 'package:events_app/shared/domain/entities/user.dart';

abstract class UserRepository {
  Future<User?> getUserById(String userId);
  Future<User?> getUserByEmail(String mail);
  Future<List<User>> getAllUsers();
  Future<void> addUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String userId);
  // Future<void> clearUsers();
}
