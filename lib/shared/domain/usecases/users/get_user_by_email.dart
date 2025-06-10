import 'package:events_app/shared/domain/entities/user.dart';
import 'package:events_app/shared/domain/repositories/user_repository.dart';

class GetUserByEmail {
  final UserRepository userRepository;

  GetUserByEmail(this.userRepository);

  Future<User?> call(String email) async {
    return userRepository.getUserByEmail(email);
  }
}
