import 'package:flutter/material.dart';
import 'package:events_app/features/auth/presentation/pages/login_screen.dart';
import 'package:events_app/features/auth/presentation/pages/pin_login_screen.dart';
import 'package:events_app/shared/domain/entities/auth_status.dart';
import 'package:events_app/shared/presentation/providers/session_provider.dart';
import 'package:events_app/shared/presentation/screens/root_app_flow.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentSession = context.watch<SessionProvider>().currentSession;
    switch (currentSession.status) {
      case UserStatus.uninitialized:
        return const _LoadingScaffold();

      case UserStatus.unauthenticated:
        return const LoginScreen();

      case UserStatus.pinRequired:
        return PinLoginScreen(mail: currentSession.mail);

      case UserStatus.authenticated:
        return const RootAppFlow();
    }
  }
}

class _LoadingScaffold extends StatelessWidget {
  const _LoadingScaffold();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
