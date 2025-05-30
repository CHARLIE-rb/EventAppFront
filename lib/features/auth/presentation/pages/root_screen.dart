import 'package:flutter/material.dart';
import 'package:flutterv1/features/auth/domain/entities/auth_status.dart';
import 'package:flutterv1/features/auth/presentation/pages/login_screen.dart';
import 'package:flutterv1/features/auth/presentation/pages/pin_login_screen.dart';
import 'package:flutterv1/features/auth/presentation/pages/root_app_flow.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.watch<AuthProvider>().authStatus;
    switch (status) {
      case AuthStatus.uninitialized:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case AuthStatus.unauthenticated:
        return const LoginScreen();
      case AuthStatus.pinRequired:
        return const PinLoginScreen();
      case AuthStatus.authenticated:
        return const RootAppFlow();
    }
  }
}
