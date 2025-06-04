import 'package:flutterv1/shared/domain/entities/user.dart';
import 'package:flutterv1/shared/data/models/user_model.dart';
import 'package:smartstruct/smartstruct.dart';

part 'user_mapper.mapper.g.dart';

@Mapper()
abstract class UserMapper {
  User toUser(UserModel model);
  UserModel toModel(User user);
  Role roleFromString(String role) {
    return Role.values.firstWhere(
      (e) => e.name == role,
      orElse: () {
        throw ArgumentError('Role inválido: $role');
      },
    );
  }

  String roleToString(Role role) {
    return role.name;
  }
}
