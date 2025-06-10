import 'package:events_app/shared/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:events_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:events_app/shared/presentation/providers/session_provider.dart';
import 'package:events_app/shared/presentation/screens/root_screen.dart';
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
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('es', null);

  await initDI();

  final sessionProvider = getIt<SessionProvider>();
  final eventsProvider = getIt<EventsNotifier>();
  await sessionProvider.initialize();
  eventsProvider.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: sessionProvider),
        ChangeNotifierProvider.value(value: getIt<AuthProvider>()),
        ChangeNotifierProvider.value(value: getIt<UserProvider>()),
        ChangeNotifierProvider.value(value: getIt<NavNotifier>()),
        ChangeNotifierProvider.value(value: getIt<SettingsProvider>()),
        ChangeNotifierProvider.value(value: getIt<ThemeProvider>()),
        ChangeNotifierProvider.value(value: eventsProvider),
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
      title: 'Events App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProv.mode,
      home: const RootScreen(),
      routes: AppRoutes.routes,
      onUnknownRoute: AppRoutes.onUnknownRoute,
    );
  }
}
