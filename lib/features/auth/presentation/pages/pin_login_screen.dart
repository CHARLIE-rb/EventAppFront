import 'package:flutter/material.dart';
import 'package:flutterv1/config/app_constants.dart';
import 'package:flutterv1/features/auth/domain/entities/user.dart';
import 'package:flutterv1/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutterv1/features/theme/presentation/providers/theme_provider.dart';
import 'package:flutterv1/shared/widgets/mini/invierte_imagen_black_and_white.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class PinLoginScreen extends StatefulWidget {
  const PinLoginScreen({super.key});

  @override
  State<PinLoginScreen> createState() => _PinLoginScreenState();
}

class _PinLoginScreenState extends State<PinLoginScreen> {
  final List<String> _currentPin = [];
  final LocalAuthentication _auth = LocalAuthentication();
  bool didAuth = false;

  Future<void> _authenticateBiometrics() async {
    bool canCheck =
        await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
    if (!canCheck) {
      _showError("Tu dispositivo no soporta biometría");
      return;
    }

    try {
      didAuth = await _auth.authenticate(
        localizedReason: 'Autentícate para acceder',
        options: AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      _showError("Error de autenticación: $e");
    }
    // if (mounted && didAuth) {
    //   Navigator.of(
    //     context,
    //     // ).pushReplacement(MaterialPageRoute(builder: (_) => RootAppFlow()));
    //   ).pushReplacement(
    //     MaterialPageRoute(
    //       builder:
    //           (_) => ChangeNotifierProvider(
    //             create: (_) => getIt<EventsNotifier>(),
    //             child: RootAppFlow(),
    //           ),
    //     ),
    //   );
    // }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _onKeyPressed(String value) {
    setState(() {
      if (_currentPin.length < AppConstants.MAX_LENGTH_PASS) {
        _currentPin.add(value);
        if (_currentPin.length == AppConstants.MAX_LENGTH_PASS) {
          _verifyPin();
        }
      }
    });
  }

  void _verifyPin() async {
    final entered = _currentPin.join();
    try {
      didAuth = await context.read<AuthProvider>().loginPin(entered);
    } catch (e) {
      _showError("Error de autenticación: $e");
    }
    if (!mounted || !didAuth) {
      _showError("PIN incorrecto");
      setState(() {
        _currentPin.clear();
      });
    }
  }

  Widget _buildPinIndicators(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(AppConstants.MAX_LENGTH_PASS, (i) {
        bool filled = i < _currentPin.length;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color:
                filled
                    ? theme.colorScheme.primary
                    : theme.colorScheme.secondary,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  Widget _buildNumKey(
    String val,
    ThemeData theme, {
    Widget? child,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: InkWell(
          onTap: onTap ?? () => _onKeyPressed(val),
          borderRadius: BorderRadius.circular(40),
          child: Center(
            child:
                child ??
                Text(
                  val,
                  style: TextStyle(
                    fontSize: 28,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    User? user = context.read<AuthProvider>().user;
    String userName = user?.name ?? "Jhon";

    return Scaffold(
      // 1) AppBar transparente arriba
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              theme.brightness == Brightness.light
                  ? Icons
                      .dark_mode_outlined // si está oscuro, muestro “dark”
                  : Icons.light_mode_outlined, // si está claro, “light”
              color: theme.colorScheme.onSurface,
            ),
            onPressed: () => context.read<ThemeProvider>().toggle(),
          ),
        ],
      ),

      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 24),
            CircleAvatar(
              child: InvierteImagenBnW(
                theme: theme,
                imagePath:
                    AppConstants
                        .LOGO_PATH, //Aqui debería ir el logo de la empresa
                width: 50,
              ),
            ),
            SizedBox(height: 12),
            Text("Welcome back, $userName", style: theme.textTheme.titleLarge),
            SizedBox(height: 24),
            _buildPinIndicators(theme),
            Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  for (var row in [
                    ["1", "2", "3"],
                    ["4", "5", "6"],
                    ["7", "8", "9"],
                  ])
                    Row(
                      children: row.map((n) => _buildNumKey(n, theme)).toList(),
                    ),
                  Row(
                    children: [
                      _buildNumKey(
                        "",
                        theme,
                        child: Icon(
                          Icons.face,
                          size: 32,
                          color: theme.colorScheme.onSurface,
                        ),
                        onTap: _authenticateBiometrics,
                      ),
                      _buildNumKey("0", theme),
                      // Espacio en blanco para simetría
                      // Expanded(child: SizedBox()),
                      _buildNumKey(
                        "",
                        theme,
                        child: Icon(
                          Icons.backspace,
                          size: 32,
                          color: theme.colorScheme.onSurface,
                        ),
                        onTap: () {
                          setState(() {
                            if (_currentPin.isNotEmpty) {
                              _currentPin.removeLast();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            TextButton(
              onPressed: () {
                // TODO: flujo de recuperación de PIN
              },
              child: Text(
                "Forgot your passcode?",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
