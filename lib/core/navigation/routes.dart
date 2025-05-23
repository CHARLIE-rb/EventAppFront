// lib/src/routes.dart
import 'package:flutter/material.dart';
import 'package:flutterv1/features/auth/presentation/pages/forgot_password.dart';
import 'package:flutterv1/features/auth/presentation/pages/login_screen.dart';
import 'package:flutterv1/features/auth/presentation/pages/register_screen.dart';
import 'package:flutterv1/features/auth/presentation/pages/root_screen.dart';

class AppRoutes {
  // 1. Definición de nombres de ruta como constantes
  static const String root = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String recover = '/recover';
  // static const String home = '/home'; // aquí podrías poner tu RootAppFlow

  // 2. Mapa de rutas
  static final Map<String, WidgetBuilder> routes = {
    root: (BuildContext ctx) => const RootScreen(),
    login: (BuildContext ctx) => const LoginScreen(),
    signup: (BuildContext ctx) => const RegisterScreen(),
    recover: (BuildContext ctx) => const ForgotPassword(),
    // home:
    //     (BuildContext ctx) => ChangeNotifierProvider(
    //       create: (_) => getIt<NavNotifier>(),
    //       child: const RootAppFlow(),
    //     ),
  };

  // 3. (Opcional) Función para generar rutas dinámicas / interceptar rutas desconocidas
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // ejemplo: rutas con parámetros
    // if (settings.name!.startsWith('/detail/')) {
    //   final id = settings.name!.split('/').last;
    //   return MaterialPageRoute(builder: (_) => DetailScreen(id: id));
    // }
    return null;
  }

  // 4. (Opcional) Pantalla por defecto para rutas desconocidas
  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('Ruta no encontrada')),
          body: Center(child: Text('No existe la ruta: ${settings.name}')),
        );
      },
    );
  }
}
