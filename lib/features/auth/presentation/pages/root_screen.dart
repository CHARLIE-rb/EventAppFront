import 'package:flutter/material.dart';
import 'package:flutterv1/features/auth/presentation/pages/login_screen.dart';
import 'package:flutterv1/features/auth/presentation/pages/pin_login_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return auth.isLoggedIn ? PinLoginScreen() : LoginScreen();
  }
}
