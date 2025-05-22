// lib/pages/register_page.dart
import 'package:flutter/material.dart';
import 'package:flutterv1/src/lib/constants/app_constants.dart';
import 'package:flutterv1/src/models/role.dart';
import 'package:flutterv1/src/models/user.dart';
import 'package:flutterv1/src/providers/auth_provider.dart';
import 'package:flutterv1/src/widgets/mini/invierte_imagen_black_and_white.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final authProvider = AuthProvider();

  // Controllers para cada campo
  final _companyIdCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _pinCtrl = TextEditingController();
  Role? _selectedRole;

  @override
  void dispose() {
    // liberar controladores
    _companyIdCtrl.dispose();
    _nameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _pinCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true || _selectedRole == null) {
      // mostrar error si no hay rol seleccionado
      if (_selectedRole == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Por favor selecciona un rol.')));
      }
      return;
    }

    final newUser = User(
      id: '', // se genera en el servidor
      companyId: int.parse(_companyIdCtrl.text.trim()),
      name: _nameCtrl.text.trim(),
      lastName: _lastNameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      password: _passwordCtrl.text,
      pin: _pinCtrl.text,
      role: _selectedRole!,
    );

    authProvider.register(newUser);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // Sin AppBar, para emular la pantalla que mostraste
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo GFT
              Center(
                child: InvierteImagenBnW(
                  theme: theme,
                  imagePath: AppConstants.LOGO_PATH,
                  width: 100,
                ),
              ),
              SizedBox(height: 48),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Company ID
                    _buildTextField(
                      controller: _companyIdCtrl,
                      hintText: 'ID de Empresa',
                      icon: Icons.business,
                      keyboardType: TextInputType.number,
                      validator:
                          (s) =>
                              s != null && s.trim().isNotEmpty
                                  ? null
                                  : 'Requerido',
                    ),

                    SizedBox(height: 16),
                    // Nombre
                    _buildTextField(
                      controller: _nameCtrl,
                      hintText: 'Nombre',
                      icon: Icons.person,
                      validator:
                          (s) =>
                              s != null && s.trim().isNotEmpty
                                  ? null
                                  : 'Requerido',
                    ),

                    SizedBox(height: 16),
                    // Apellido
                    _buildTextField(
                      controller: _lastNameCtrl,
                      hintText: 'Apellido',
                      icon: Icons.person_outline,
                      validator:
                          (s) =>
                              s != null && s.trim().isNotEmpty
                                  ? null
                                  : 'Requerido',
                    ),

                    SizedBox(height: 16),
                    // Correo electrónico
                    _buildTextField(
                      controller: _emailCtrl,
                      hintText: 'Correo electrónico',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (s) {
                        if (s == null || s.isEmpty) return 'Requerido';
                        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                        if (!emailRegex.hasMatch(s)) return 'Email inválido';
                        return null;
                      },
                    ),

                    SizedBox(height: 16),
                    // Contraseña
                    _buildTextField(
                      controller: _passwordCtrl,
                      hintText: 'Contraseña',
                      icon: Icons.lock_outline,
                      obscureText: true,
                      validator:
                          (s) =>
                              s != null && s.length >= 6
                                  ? null
                                  : 'Mínimo 6 caracteres',
                    ),

                    SizedBox(height: 16),
                    // PIN
                    _buildTextField(
                      controller: _pinCtrl,
                      hintText: 'PIN (4 dígitos)',
                      icon: Icons.pin,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      validator:
                          (s) =>
                              s != null && s.length == 4
                                  ? null
                                  : 'Debe tener 4 dígitos',
                    ),

                    SizedBox(height: 16),
                    // Dropdown de Roles
                    DropdownButtonFormField<Role>(
                      value: _selectedRole,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.shield_outlined),
                        hintText: 'Selecciona un rol',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                      ),
                      items:
                          Role.values.map((rol) {
                            return DropdownMenuItem(
                              value: rol,
                              child: Text(rol.name),
                            );
                          }).toList(),
                      onChanged: (r) => setState(() => _selectedRole = r),
                      validator:
                          (_) => _selectedRole == null ? 'Requerido' : null,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32),
              // Botón de Registrarse
              ElevatedButton.icon(
                onPressed: _submit,
                icon: Icon(Icons.arrow_forward),
                label: Text('Registrarse'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: StadiumBorder(),
                ),
              ),

              SizedBox(height: 24),
              // Link a login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('¿Ya tienes una cuenta?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Iniciar sesión'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
