import 'package:flutterv1/shared/data/models/user_model.dart';

abstract class UserDataSource {
  Future<UserModel> getUserById(String userId);
  Future<List<UserModel>> getAllUsers();
  Future<void> addUser(UserModel user);
  Future<void> updateUser(UserModel user);
  Future<void> deleteUser(String userId);
  // Future<void> clearUsers(); // Uncomment if needed
}
