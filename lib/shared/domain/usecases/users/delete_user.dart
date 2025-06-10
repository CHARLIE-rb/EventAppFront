import 'package:events_app/shared/domain/repositories/user_repository.dart';

class DeleteUser {
  final UserRepository userRepository;
  DeleteUser(this.userRepository);
  Future<void> call(String userId) async {
    await userRepository.deleteUser(userId);
  }
}
