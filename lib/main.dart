// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutterv1/core/navigation/routes.dart';
// import 'package:intl/date_symbol_data_file.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializa solo la localización 'es' (o null para todas)
  await initializeDateFormatting('es', null);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        // ChangeNotifierProvider(create: (_) => CartProvider()),
        // Provider(create: (_) => ProductsService()), // un servicio “simple”
        // FutureProvider<List<Product>>(
        // un provider asíncrono
        // create: (_) => ProductsService().fetchAll(),
        // initialData: const [],
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
      initialRoute: AppRoutes.root, // ruta inicial
      routes: AppRoutes.routes, // rutas definidas en AppRoutes
      onUnknownRoute: AppRoutes.onUnknownRoute, // ruta desconocida
    );
  }
}
