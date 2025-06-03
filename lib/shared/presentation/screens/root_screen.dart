import 'package:flutter/material.dart';
import 'package:flutterv1/shared/domain/entities/auth_status.dart';
import 'package:flutterv1/features/auth/presentation/pages/login_screen.dart';
import 'package:flutterv1/features/auth/presentation/pages/pin_login_screen.dart';
import 'package:flutterv1/shared/presentation/providers/session_provider.dart';
import 'package:flutterv1/shared/presentation/screens/root_app_flow.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.watch<SessionProvider>().authStatus;
    switch (status) {
      case UserStatus.uninitialized:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case UserStatus.unauthenticated:
        return const LoginScreen();
      case UserStatus.pinRequired:
        return const PinLoginScreen();
      case UserStatus.authenticated:
        return const RootAppFlow();
    }
  }
}
