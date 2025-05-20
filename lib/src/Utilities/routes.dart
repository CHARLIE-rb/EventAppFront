// lib/src/routes.dart
import 'package:flutter/material.dart';
import 'package:flutterv1/src/screens/auth/forgot_password.dart';
import 'package:flutterv1/src/screens/auth/login_screen.dart';
import 'package:flutterv1/src/screens/auth/register_screen.dart';
import 'package:flutterv1/src/screens/root_app_flow.dart';
import 'package:flutterv1/src/screens/root_screen.dart';

class AppRoutes {
  // 1. Definición de nombres de ruta como constantes
  static const String root = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String recover = '/recover';
  static const String home = '/home'; // aquí podrías poner tu RootAppFlow

  // 2. Mapa de rutas
  static final Map<String, WidgetBuilder> routes = {
    root: (BuildContext ctx) => const RootScreen(),
    login: (BuildContext ctx) => const LoginScreen(),
    signup: (BuildContext ctx) => const RegisterScreen(),
    recover: (BuildContext ctx) => const ForgotPassword(),
    home: (BuildContext ctx) => const RootAppFlow(),
  };

  // 3. (Opcional) Función para generar rutas dinámicas / interceptar rutas desconocidas
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // Por ejemplo, podrías manejar rutas con parámetros aquí
    // if (settings.name!.startsWith('/detail/')) { ... }

    // Si no coinciden, puedes devolver null para que Flutter use el mapa estático
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
