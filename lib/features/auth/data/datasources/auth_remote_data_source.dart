import 'package:flutterv1/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutterv1/features/auth/data/models/user_model.dart';

class AuthRemoteDataSourceImpl implements AuthDataSource {
  @override
  Future<UserModel> loginWithEmail(String email, String password) async {
    // TODO: reemplazar por llamada HTTP cuando tengas backend
    // Por ahora, lanza excepción para simular fallo o retorna un mock
    throw UnimplementedError();
  }

  @override
  Future<UserModel> loginWithPin(String id, String pin) {
    // TODO: implement loginWithPin
    throw UnimplementedError();
  }

  @override
  Future<void> changeAddress(String newAddress) {
    // TODO: implement changeAddress
    throw UnimplementedError();
  }

  @override
  Future<void> changeBio(String newBio) {
    // TODO: implement changeBio
    throw UnimplementedError();
  }

  @override
  Future<void> changeEmail(String newEmail) {
    // TODO: implement changeEmail
    throw UnimplementedError();
  }

  @override
  Future<void> changeLanguage(String newLanguage) {
    // TODO: implement changeLanguage
    throw UnimplementedError();
  }

  @override
  Future<void> changeNotificationSettings(
    Map<String, bool> newNotificationSettings,
  ) {
    // TODO: implement changeNotificationSettings
    throw UnimplementedError();
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<void> changePhoneNumber(String newPhoneNumber) {
    // TODO: implement changePhoneNumber
    throw UnimplementedError();
  }

  @override
  Future<void> changePrivacySettings(Map<String, bool> newPrivacySettings) {
    // TODO: implement changePrivacySettings
    throw UnimplementedError();
  }

  @override
  Future<void> changeProfilePicture(String newProfilePicture) {
    // TODO: implement changeProfilePicture
    throw UnimplementedError();
  }

  @override
  Future<void> changeSocialMediaLinks(Map<String, String> newSocialMediaLinks) {
    // TODO: implement changeSocialMediaLinks
    throw UnimplementedError();
  }

  @override
  Future<void> changeUsername(String newUsername) {
    // TODO: implement changeUsername
    throw UnimplementedError();
  }

  @override
  Future<void> changeWebsite(String newWebsite) {
    // TODO: implement changeWebsite
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUser(String id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<UserModel> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<UserModel> register(UserModel user) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<void> resetPassword(String email) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<void> sendVerificationEmail(String email) {
    // TODO: implement sendVerificationEmail
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(UserModel user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<void> verifyEmail(String email) {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }
}
