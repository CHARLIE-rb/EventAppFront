import 'package:flutter/material.dart';
import 'package:events_app/core/navigation/routes.dart';
import 'package:events_app/config/app_constants.dart';
import 'package:events_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:events_app/features/theme/presentation/providers/theme_provider.dart';
import 'package:events_app/shared/presentation/providers/session_provider.dart';
import 'package:events_app/shared/presentation/widgets/mini/invierte_imagen_black_and_white.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _emailOrUsername = '';
  String _password = '';
  String? _error;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: AppBar(
        title: Text(
          'Login',
          style: theme.textTheme.headlineLarge?.copyWith(
            color: theme.colorScheme.onPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              !isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
              color: theme.colorScheme.onSurface,
            ),
            onPressed: () => context.read<ThemeProvider>().toggle(),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              InvierteImagenBnW(
                theme: theme,
                imagePath: AppConstants.logoPath,
                width: 300,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 32,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.email),
                          hintText: 'Enter Your Username/Email',
                          hintStyle: theme.textTheme.bodyMedium,
                          labelText: 'Email or Username',
                          labelStyle: theme.textTheme.bodyLarge,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Requerido';
                          }
                          return null;
                        },
                        onSaved: (v) => _emailOrUsername = v!.trim(),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          hintText: 'Enter Your Password',
                          hintStyle: theme.textTheme.bodyMedium,
                          labelText: 'Password',
                          labelStyle: theme.textTheme.bodyLarge,
                        ),
                        validator: (v) {
                          if (v == null ||
                              v.length < AppConstants.maxLengthPass) {
                            return 'Mínimo ${AppConstants.maxLengthPass} caracteres';
                          }
                          return null;
                        },
                        onSaved: (v) => _password = v!.trim(),
                      ),

                      if (_error != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          _error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                      const SizedBox(height: 16),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed:
                              () => Navigator.pushNamed(
                                context,
                                AppRoutes.recover,
                              ),
                          child: const Text('Forgot Password?'),
                        ),
                      ),
                      const SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: theme.colorScheme.onPrimary,
                            shape: const StadiumBorder(),
                            elevation: 0,
                          ),
                          onPressed: _isLoading ? null : _submit,
                          child:
                              _isLoading
                                  ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                  : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.login),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Sign In',
                                        style: theme.textTheme.displayLarge
                                            ?.copyWith(
                                              color: theme.colorScheme.surface,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed:
                                () => Navigator.pushNamed(
                                  context,
                                  AppRoutes.signup,
                                ),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    setState(() {
      _error = null;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() => _isLoading = true);
      try {
        await context.read<AuthProvider>().loginMail(
          _emailOrUsername,
          _password,
        );
        if (mounted) {
          context.read<SessionProvider>().reload();
        }
      } catch (e) {
        setState(() {
          _error = e.toString();
        });
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }
}
