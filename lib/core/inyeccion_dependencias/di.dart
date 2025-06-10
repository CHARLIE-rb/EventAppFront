import 'package:events_app/core/inyeccion_dependencias/companies/companies_di.dart';
import 'package:events_app/core/inyeccion_dependencias/navigation/nav_di.dart';
import 'package:events_app/core/inyeccion_dependencias/profile/profile_di.dart';
import 'package:events_app/features/settings/presentation/providers/settings_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:events_app/core/inyeccion_dependencias/shared/shared_di.dart';
import 'package:events_app/core/inyeccion_dependencias/auth/auth_di.dart';
import 'package:events_app/core/inyeccion_dependencias/events/events_di.dart';
import 'package:events_app/features/theme/presentation/providers/theme_provider.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDI() async {
  getIt.registerFactory<ThemeProvider>(() => ThemeProvider());
  await initSharedModule(getIt);
  initAuthModule(getIt);
  initEventsModule(getIt);
  initNavModule(getIt);
  initProfileModule(getIt);
  getIt.registerFactory<SettingsProvider>(() => SettingsProvider());
  initCompaniesModule(getIt);
  await getIt.allReady();
}
