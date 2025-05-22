// lib/core/di.dart

import 'package:flutterv1/features/navigation/domain/usecases/get_nav_items.dart';
import 'package:flutterv1/features/navigation/presentation/providers/nav_notifier.dart';
import 'package:get_it/get_it.dart';

// Providers
import 'package:flutterv1/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutterv1/features/settings/presentation/providers/settings_provider.dart';
import 'package:flutterv1/features/theme/presentation/providers/theme_provider.dart';

// (Aquí podrías añadir repos, datasources, usecases, etc.)
final GetIt getIt = GetIt.instance;

void init() {
  // ----- AUTH -----
  // Cambia AuthService por tu implementación real si la registras aquí
  getIt.registerLazySingleton<AuthProvider>(() => AuthProvider());

  // ----- SETTINGS -----
  getIt.registerLazySingleton<SettingsProvider>(() => SettingsProvider());

  // ----- THEME -----
  getIt.registerLazySingleton<ThemeProvider>(() => ThemeProvider());

  // Ejemplo de cómo registrar un datasource / repositorio:
  // getIt.registerLazySingleton<EventRemoteDataSource>(
  //   () => EventRemoteDataSourceImpl(getIt()),
  // );
  // getIt.registerLazySingleton<EventRepository>(
  //   () => EventRepositoryImpl(getIt()),
  // );
  // getIt.registerLazySingleton(() => GetAllEvents(getIt()));

  getIt.registerLazySingleton(() => GetNavItems());
  getIt.registerFactory<NavNotifier>(
    () => NavNotifier(getIt(), getIt<AuthProvider>()),
  );
}
