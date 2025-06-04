import 'package:flutter/material.dart';
import 'package:flutterv1/features/auth/presentation/pages/login_screen.dart';
import 'package:flutterv1/features/auth/presentation/pages/pin_login_screen.dart';
import 'package:flutterv1/shared/domain/entities/auth_status.dart';
import 'package:flutterv1/shared/presentation/providers/session_provider.dart';
import 'package:flutterv1/shared/presentation/screens/root_app_flow.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionProvider>(
      builder: (context, sessionProv, _) {
        final session = sessionProv.currentSession;

        switch (session.status) {
          case UserStatus.uninitialized:
            return const _LoadingScaffold();

          case UserStatus.unauthenticated:
            return const LoginScreen();

          case UserStatus.pinRequired:
            return PinLoginScreen(username: session.username);

          case UserStatus.authenticated:
            return const RootAppFlow();
        }
      },
    );
  }
}

class _LoadingScaffold extends StatelessWidget {
  const _LoadingScaffold();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
