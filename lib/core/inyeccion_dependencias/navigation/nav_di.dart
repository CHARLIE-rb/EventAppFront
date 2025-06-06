import 'package:events_app/features/navigation/domain/usecases/get_nav_items.dart';
import 'package:events_app/features/navigation/presentation/providers/nav_notifier.dart';
import 'package:events_app/shared/domain/usecases/session/get_current_user.dart';
import 'package:get_it/get_it.dart';

Future<void> initNavModule(GetIt getIt) async {
  getIt.registerLazySingleton<GetNavItems>(() => GetNavItems());
  getIt.registerSingletonAsync<NavNotifier>(
    () async => NavNotifier(getIt<GetNavItems>(), getIt<GetCurrentUser>()),
    dependsOn: [GetCurrentUser],
  );
}
