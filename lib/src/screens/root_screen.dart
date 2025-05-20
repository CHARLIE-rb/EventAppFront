import 'package:flutter/material.dart';
import 'package:flutterv1/src/screens/auth/login_screen.dart';
// import 'package:flutterv1/src/screens/auth/signup.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'auth/pin_login_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return auth.isLoggedIn
        ? PinLoginScreen() // tu pantalla con BottomNav + contenido por rol
        : LoginScreen(); // flujo de autenticación
  }
}
