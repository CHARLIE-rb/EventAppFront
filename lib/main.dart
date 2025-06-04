import 'package:flutter/material.dart';
import 'package:flutterv1/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutterv1/shared/presentation/providers/session_provider.dart';
import 'package:flutterv1/shared/presentation/screens/root_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/inyeccion_dependencias/di.dart';
import 'core/navigation/routes.dart';
import 'shared/presentation/themes/app_theme_style.dart';
import 'features/settings/presentation/providers/settings_provider.dart';
import 'features/theme/presentation/providers/theme_provider.dart';
import 'features/events/presentation/providers/events_notifier.dart';
import 'features/navigation/presentation/providers/nav_notifier.dart';

Future<void> main() async {
  // A) Asegurarnos de inicializar FlutterBinding
  WidgetsFlutterBinding.ensureInitialized();

  // B) Inicializar localizaciones de intl
  await initializeDateFormatting('es', null);

  // C) Inicializar TODO el gráfico de dependencias de GetIt y esperar a allReady()
  await initDI();
  await getIt.isReady<SessionProvider>();
  // D) Una vez que GetIt ya ha creado el CredentialStorage, SessionRepository,
  //    AuthRepository (con auto-login), usecases, notifiers, etc., sólo entonces
  //    arrancamos la UI. A partir de aquí, todos los “getIt<X>()” devuelven un objeto válido.
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => getIt<AuthProvider>(),
        ),
        ChangeNotifierProvider<SessionProvider>(
          create: (_) => getIt<SessionProvider>(),
        ),
        ChangeNotifierProvider<SettingsProvider>(
          create: (_) => getIt<SettingsProvider>(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => getIt<ThemeProvider>(),
        ),
        ChangeNotifierProvider<EventsNotifier>(
          create: (_) => getIt<EventsNotifier>(),
        ),
        ChangeNotifierProvider<NavNotifier>(
          create: (_) => getIt<NavNotifier>(),
        ),
        // ChangeNotifierProvider<CompaniesNotifier>(
        //   create: (_) => getIt<CompaniesNotifier>(),
        // ),
      ],
      child: const MyApp(),
    ),
  );
}

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
      home: const RootScreen(),
      // initialRoute: AppRoutes.root,
      routes: AppRoutes.routes,
      onUnknownRoute: AppRoutes.onUnknownRoute,
    );
  }
}
