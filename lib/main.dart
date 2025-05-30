// lib/main.dart

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/inyeccion_dependencias/di.dart';
import 'core/navigation/routes.dart';
import 'shared/themes/app_theme_style.dart';

import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/settings/presentation/providers/settings_provider.dart';
import 'features/theme/presentation/providers/theme_provider.dart';
import 'features/events/presentation/providers/events_notifier.dart';
import 'features/navigation/presentation/providers/nav_notifier.dart';

void main() {
  // Asegura que Flutter y sus plugins puedan inicializarse correctamente
  WidgetsFlutterBinding.ensureInitialized();
  // Arrancamos la app anclada a AppRoot
  runApp(const AppRoot());
}

/// Widget raíz que espera inicializaciones antes de montar la app real
class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      // Aquí ejecutamos TODO lo que antes hacías en main()
      future: _initApp(),
      builder: (context, snapshot) {
        // Mientras tanto, mostramos un Splash con un loader sencillo
        if (snapshot.connectionState != ConnectionState.done) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        // Cuando _initApp() complete sin errores, montamos el árbol de Providers
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>(
              create: (_) => GetIt.I<AuthProvider>(),
            ),
            ChangeNotifierProvider<SettingsProvider>(
              create: (_) => GetIt.I<SettingsProvider>(),
            ),
            ChangeNotifierProvider<ThemeProvider>(
              create: (_) => GetIt.I<ThemeProvider>(),
            ),
            ChangeNotifierProvider<EventsNotifier>(
              create: (_) => GetIt.I<EventsNotifier>(),
            ),
            ChangeNotifierProxyProvider<AuthProvider, NavNotifier>(
              create: (_) => GetIt.I<NavNotifier>(),
              update: (_, auth, nav) => nav!,
            ),
          ],
          child: const MyApp(),
        );
      },
    );
  }

  /// Esta función corre dentro del FutureBuilder, una vez #runApp ya ha
  /// registrado los plugins nativos (incluyendo SharedPreferences).
  Future<void> _initApp() async {
    // 1) Inicializamos formatos de fecha/localización
    await initializeDateFormatting('es', null);

    // 2) Registramos todos los módulos de GetIt (incluyendo initAuthModule)
    init();

    // 3) Esperamos a que terminen todas las inyecciones async:
    //    - LocalCredentialStorage.init() (SharedPreferences)
    //    - AuthRepository.loadCredentials() (auto-login)
    //    - Cualquier otra registerSingletonAsync o registerFactoryAsync
    await GetIt.I.allReady();
  }
}

/// Tu aplicación real, tras el Splash
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProv = context.watch<ThemeProvider>();
    return MaterialApp(
      title: 'Mi Flutter App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProv.mode,
      initialRoute: AppRoutes.root,
      routes: AppRoutes.routes,
      onUnknownRoute: AppRoutes.onUnknownRoute,
    );
  }
}
