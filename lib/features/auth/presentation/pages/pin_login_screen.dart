import 'package:flutter/material.dart';
import 'package:events_app/config/app_constants.dart';
import 'package:events_app/shared/domain/entities/user.dart';
import 'package:events_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:events_app/features/theme/presentation/providers/theme_provider.dart';
import 'package:events_app/shared/presentation/providers/session_provider.dart';
import 'package:events_app/shared/presentation/widgets/mini/invierte_imagen_black_and_white.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class PinLoginScreen extends StatefulWidget {
  const PinLoginScreen({super.key, this.mail});

  final String? mail;

  @override
  State<PinLoginScreen> createState() => _PinLoginScreenState();
}

class _PinLoginScreenState extends State<PinLoginScreen> {
  final List<String> _currentPin = [];
  final ValueNotifier<int> _pinLen = ValueNotifier<int>(0);
  final LocalAuthentication _auth = LocalAuthentication();
  bool didAuth = false;
  @override
  void dispose() {
    _pinLen.dispose();
    super.dispose();
  }

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
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _onBackspace() {
    if (_currentPin.isNotEmpty) {
      _currentPin.removeLast();
      _pinLen.value = _currentPin.length;
    }
  }

  void _onKeyPressed(String value) {
    if (_currentPin.length < AppConstants.maxLengthPass) {
      _currentPin.add(value);
      _pinLen.value = _currentPin.length;
      if (_currentPin.length == AppConstants.maxLengthPass) {
        _verifyPin();
      }
    }
  }

  Future<void> _verifyPin() async {
    final entered = _currentPin.join();
    try {
      final ok = await context.read<AuthProvider>().loginPin(
        widget.mail!,
        entered,
      );
      if (mounted && ok) {
        context.read<SessionProvider>().reload();
      } else {
        _showError(AppConstants.errorMessagePinLogin);
        _currentPin.clear();
        _pinLen.value = 0;
      }
    } catch (e) {
      _showError(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Widget _buildPinIndicators(ThemeData theme) {
    return ValueListenableBuilder<int>(
      valueListenable: _pinLen,
      builder: (_, len, __) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(AppConstants.maxLengthPass, (i) {
            final filled = i < len;
            return AnimatedContainer(
              // pequeño efecto de relleno
              duration: const Duration(milliseconds: 150),
              margin: const EdgeInsets.symmetric(horizontal: 8),
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
      },
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

    // 1) obtenemos el Future<User?> que expone SessionProvider
    final futureUser = context.read<SessionProvider>().currentUser;

    return FutureBuilder<User?>(
      future: futureUser,
      builder: (context, snapshot) {
        // Mientras el Future no termine, mostrar un loader o un estado por defecto
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Si el Future completó con error, podemos avisar al usuario
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                "Error al cargar datos del usuario: ${snapshot.error}",
              ),
            ),
          );
        }

        // Llegados a este punto, el Future terminó (connectionState == done)
        // y snapshot.data puede ser null (usuario no existe) o un User válido
        User? user = snapshot.data;
        String userName = user?.name ?? "";

        // Ahora construimos la pantalla normal con userName ya “resuelto”
        return Scaffold(
          // 1) AppBar transparente arriba
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(
                  theme.brightness == Brightness.light
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
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
                const SizedBox(height: 24),
                CircleAvatar(
                  child: InvierteImagenBnW(
                    theme: theme,
                    imagePath: AppConstants.logoPath,
                    width: 50,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Welcome back $userName",
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 24),
                _buildPinIndicators(theme),
                const Spacer(),
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
                          children:
                              row.map((n) => _buildNumKey(n, theme)).toList(),
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
                          _buildNumKey(
                            "",
                            theme,
                            child: Icon(
                              Icons.backspace,
                              size: 32,
                              color: theme.colorScheme.onSurface,
                            ),
                            onTap: _onBackspace,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
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
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
