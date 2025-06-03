import 'package:flutter/material.dart';
import 'package:flutterv1/shared/presentation/screens/root_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/inyeccion_dependencias/di.dart';
import 'core/navigation/routes.dart';
import 'shared/presentation/themes/app_theme_style.dart';

import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/settings/presentation/providers/settings_provider.dart';
import 'features/theme/presentation/providers/theme_provider.dart';
import 'features/events/presentation/providers/events_notifier.dart';
import 'features/navigation/presentation/providers/nav_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initApp(),
      builder: (ctx, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>(
              create: (_) => getIt<AuthProvider>(),
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
            ChangeNotifierProxyProvider<AuthProvider, NavNotifier>(
              create: (_) => getIt<NavNotifier>(),
              update: (_, auth, nav) => nav!,
            ),
          ],
          child: const MyApp(),
        );
      },
    );
  }

  Future<void> _initApp() async {
    await initializeDateFormatting('es', null);
    initDI();
    await getIt.allReady();
  }
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
