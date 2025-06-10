import 'package:events_app/core/inyeccion_dependencias/shared/session/session_di.dart';
import 'package:events_app/core/inyeccion_dependencias/shared/users/users_di.dart';
import 'package:get_it/get_it.dart';

Future<void> initSharedModule(GetIt getIt) async {
  initSharedUsersModule(getIt);
  initSharedSessionModule(getIt);
}
