import 'package:flutter/material.dart';
import 'package:flutterv1/core/navigation/routes.dart';
import 'package:flutterv1/config/app_constants.dart';
import 'package:flutterv1/features/auth/presentation/pages/root_screen.dart';
import 'package:flutterv1/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutterv1/features/theme/presentation/providers/theme_provider.dart';
import 'package:flutterv1/shared/widgets/mini/invierte_imagen_black_and_white.dart';
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
    final auth = context.watch<AuthProvider>();
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
                imagePath: AppConstants.LOGO_PATH,
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
                          icon: Icon(
                            Icons.email,
                            color: theme.colorScheme.secondary,
                          ),
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
                              v.length < AppConstants.MAX_LENGTH_PASS) {
                            return 'Mínimo ${AppConstants.MAX_LENGTH_PASS} caracteres';
                          }
                          return null;
                        },
                        onSaved: (v) => _password = v!.trim(),
                      ),

                      if (_error != null || auth.errorMessage != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          _error ?? auth.errorMessage!,
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

                      // Botón que cambia a loading cuando _isLoading == true
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
    print('submito');

    final navigator = Navigator.of(context);

    await _subSubmit(navigator);
  }

  Future<void> _subSubmit(NavigatorState navigator) async {
    setState(() {
      _error = null;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() => _isLoading = true);
      try {
        final ok = await context.read<AuthProvider>().loginMail(
          _emailOrUsername,
          _password,
        );

        if (!ok) {
          setState(() {
            _error =
                context.read<AuthProvider>().errorMessage ??
                'Credenciales inválidas';
          });
        }
      } catch (e) {
        // Captura cualquier excepción inesperada
        setState(() {
          _error = 'Ha ocurrido un error: ${e.toString()}';
        });
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }
}
