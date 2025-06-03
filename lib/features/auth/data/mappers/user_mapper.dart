import 'package:flutterv1/features/auth/data/models/user_model.dart';
import 'package:flutterv1/features/auth/domain/entities/user.dart';
import 'package:smartstruct/smartstruct.dart';

part 'user_mapper.mapper.g.dart';

@Mapper()
abstract class UserMapper {
  User toUser(UserModel model);
  UserModel toModel(User user);
}
