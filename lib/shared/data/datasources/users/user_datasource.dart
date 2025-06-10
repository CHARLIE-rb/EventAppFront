import 'package:events_app/shared/data/models/user_model.dart';

abstract class UserDataSource {
  Future<List<UserModel>> getUsersByIds(List<String> userIds);
  Future<UserModel> getUserById(String userId);
  Future<UserModel> getUserByMail(String mail);
  Future<List<UserModel>> getAllUsers();
  Future<void> addUser(UserModel user);
  Future<void> updateUser(UserModel user);
  Future<void> deleteUser(String userId);
  // Future<void> clearUsers(); // Uncomment if needed
}
