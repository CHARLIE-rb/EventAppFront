import 'package:flutter/material.dart';
import 'package:flutterv1/src/Utilities/routes.dart';
import 'package:flutterv1/src/lib/constants/app_constants.dart';
import 'package:flutterv1/src/providers/auth_provider.dart';
import 'package:flutterv1/src/providers/theme_provider.dart';
import 'package:provider/provider.dart';
// import 'package:auth_app_flutter/Utilities/routes.dart';

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      // 1) AppBar transparente arriba
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              !isDark
                  ? Icons
                      .dark_mode_outlined // si está oscuro, muestro “dark”
                  : Icons.light_mode_outlined, // si está claro, “light”
              color: theme.colorScheme.onSurface,
            ),
            onPressed: () => context.read<ThemeProvider>().toggle(),
          ),
        ],
      ),

      backgroundColor: !isDark ? Colors.white : Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildLogo(theme),
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
                      // ElevatedButton.icon(
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor:
                      //         Theme.of(context).colorScheme.primary,
                      //     foregroundColor:
                      //         Theme.of(context).colorScheme.onPrimary,
                      //     shape: const StadiumBorder(),
                      //     elevation: 0,
                      //   ),
                      //   onPressed: _submit,
                      //   icon: const Icon(Icons.login),
                      //   label: Container(
                      //     alignment: Alignment.center,
                      //     width: 150,
                      //     height: 35,
                      //     decoration: BoxDecoration(
                      //       color: Colors.red,
                      //       borderRadius: BorderRadius.circular(25),
                      //     ),
                      //     child: Text(
                      //       'Sign In',
                      //       style: theme.textTheme.labelLarge,
                      //     ),
                      //   ),
                      // ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          shape: const StadiumBorder(),
                          elevation: 0,
                        ),
                        onPressed: _submit,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          spacing: 10,
                          children: [
                            const Icon(Icons.login),
                            Text(
                              'Sign In',
                              style: theme.textTheme.displayLarge?.copyWith(
                                color: !isDark ? Colors.white : Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
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

  void _submit() {
    setState(() => _error = null);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final ok = context.read<AuthProvider>().loginMail(
        _emailOrUsername,
        _password,
      );
      if (ok) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.home,
          (route) => false,
        );
      } else {
        setState(() {
          _error = 'Credenciales inválidas';
          _password = '';
        });
      }
    }
  }

  Widget _buildLogo(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    final filter =
        !isDark
            ? const ColorFilter.matrix(<double>[
              -1,
              0,
              0,
              0,
              255,
              0,
              -1,
              0,
              0,
              255,
              0,
              0,
              -1,
              0,
              255,
              0,
              0,
              0,
              1,
              0,
            ])
            : const ColorFilter.mode(Colors.transparent, BlendMode.multiply);

    return ColorFiltered(
      colorFilter: filter,
      child: Image.asset('assets/images/logoWilde.png'),
    );
  }
}
