// di.dart  (o donde agrupas todos los módulos de DI)

import 'package:flutterv1/core/inyeccion_dependencias/companies/companies_di.dart';
import 'package:flutterv1/features/settings/presentation/providers/settings_provider.dart';
import 'package:get_it/get_it.dart';

import 'package:flutterv1/core/inyeccion_dependencias/shared/shared_di.dart';
import 'package:flutterv1/core/inyeccion_dependencias/auth/auth_di.dart';
import 'package:flutterv1/core/inyeccion_dependencias/events/events_di.dart';

import 'package:flutterv1/features/theme/presentation/providers/theme_provider.dart';
import 'package:flutterv1/shared/presentation/providers/session_provider.dart';

import 'package:flutterv1/features/navigation/domain/usecases/get_nav_items.dart';
import 'package:flutterv1/features/navigation/presentation/providers/nav_notifier.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDI() async {
  // getIt.allowReassignment = true;

  getIt.registerFactory<ThemeProvider>(() => ThemeProvider());
  await initSharedModule(getIt);
  initAuthModule(getIt);
  initEventsModule(getIt);
  getIt.registerLazySingleton<GetNavItems>(() => GetNavItems());
  getIt.registerSingletonAsync<NavNotifier>(() async {
    return NavNotifier(
      getIt<GetNavItems>(),
      await getIt.getAsync<SessionProvider>(),
    );
  }, dependsOn: [SessionProvider]);
  getIt.registerFactory<SettingsProvider>(() => SettingsProvider());
  initCompaniesModule(getIt);
  await getIt.allReady();
}
