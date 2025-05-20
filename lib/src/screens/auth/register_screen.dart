// lib/src/screens/auth/register_screen.dart
import 'package:flutter/material.dart';
import 'package:flutterv1/src/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../../models/role.dart';
import '../../models/user.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  Role? _selectedRole;
  String _pin = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                onSaved: (v) => _name = v!,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Rol'),
                items:
                    Role.values
                        .map(
                          (r) => DropdownMenuItem(
                            value: r,
                            child: Text(r.toString().split('.').last),
                          ),
                        )
                        .toList(),
                validator: (v) => v == null ? 'Selecciona un rol' : null,
                onChanged: (v) => setState(() => _selectedRole = v),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'PIN (4 dígitos)'),
                obscureText: true,
                maxLength: 4,
                keyboardType: TextInputType.number,
                validator:
                    (v) => v == null || v.length != 4 ? '4 dígitos' : null,
                onSaved: (v) => _pin = v!,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newUser = User(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: _name,
                      role: _selectedRole!,
                      pin: _pin,
                      email: '',
                      password: '',
                      lastName: '',
                    );
                    context.read<AuthProvider>().register(newUser);
                    Navigator.pop(context);
                  }
                },
                child: Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
