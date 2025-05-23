import 'package:flutterv1/features/auth/data/models/user_model.dart';

abstract class AuthDataSource {
  Future<UserModel> loginWithEmail(String email, String password);
  Future<UserModel> loginWithPin(String id, String pin);
  Future<UserModel> register(UserModel user);
  Future<UserModel> getCurrentUser();
  Future<void> updateUser(UserModel user);
  Future<void> deleteUser(String id);
  Future<void> resetPassword(String email);
  Future<void> verifyEmail(String email);
  Future<void> sendVerificationEmail(String email);
  Future<void> changePassword(String oldPassword, String newPassword);
  Future<void> changeEmail(String newEmail);
  Future<void> changePhoneNumber(String newPhoneNumber);
  Future<void> changeProfilePicture(String newProfilePicture);
  Future<void> changeUsername(String newUsername);
  Future<void> changeBio(String newBio);
  Future<void> changeAddress(String newAddress);
  Future<void> changeWebsite(String newWebsite);
  Future<void> changeSocialMediaLinks(Map<String, String> newSocialMediaLinks);
  Future<void> changeNotificationSettings(
    Map<String, bool> newNotificationSettings,
  );
  Future<void> changePrivacySettings(Map<String, bool> newPrivacySettings);
  Future<void> changeLanguage(String newLanguage);
}
