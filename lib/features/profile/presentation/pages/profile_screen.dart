import 'package:flutter/material.dart';
import 'package:flutterv1/features/settings/presentation/widgets/settings_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos ficticios de ejemplo; en una app real vendrían de un ViewModel o un Provider.
    final String firstName = 'Carlos';
    final String lastName = 'Martínez';
    final String company = 'Tech Solutions S.L.';
    final double averageScore = 4.3; // por ejemplo, 4.3 de media
    final String profileImage =
        'assets/images/fotoPerfil.jpg'; // ruta local de la imagen

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ─────────────────────────────────────────────────────────────
          // 1) SliverAppBar expansible & pinned con foto + datos
          // ─────────────────────────────────────────────────────────────
          SliverAppBar(
            // Altura máxima cuando está desplegado
            expandedHeight: 300,
            // Hace que, al colapsar, quede “pegado” arriba
            pinned: true,
            // Podemos elegir si queremos que se “oculte” totalmente al scrollear arriba:
            floating: false,
            backgroundColor: Colors.blueAccent,
            // Si queremos, podemos quitar el sombra por defecto:
            elevation: 0,
            // El contenido flexible (imagen + textos) va dentro de FlexibleSpaceBar
            flexibleSpace: FlexibleSpaceBar(
              // Ajustamos que no se mueva el título solo, sino todo el contenido
              collapseMode: CollapseMode.parallax,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // 1.1) Fondo degradado o color liso
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blueAccent.shade700,
                          Colors.blueAccent.shade400,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),

                  // 1.2) En el centro (verticalmente) colocamos la foto + datos
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Foto de perfil en recuadro vertical
                        Container(
                          width: 120,
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage(profileImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$firstName $lastName',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),

                            // Empresa
                            Text(
                              company,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellowAccent,
                                  size: 28,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  averageScore.toStringAsFixed(1),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ─────────────────────────────────────────────────────────────
          // 2) Sección: “Datos Personales” con icono de lápiz para editar
          // ─────────────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Datos Personales',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  // Icono de lápiz para abrir un diálogo de edición
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blueAccent),
                    onPressed: () {
                      _showEditPersonalDataDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ),

          // 2.1) Contenido de Datos Personales (por ejemplo, email, teléfono, dirección)
          SliverList(
            delegate: SliverChildListDelegate([
              _buildPersonalDataItem(
                icon: Icons.email,
                label: 'Correo electrónico',
                value: 'carlos.martinez@techsolutions.com',
              ),
              _buildPersonalDataItem(
                icon: Icons.phone,
                label: 'Teléfono',
                value: '+34 612 345 678',
              ),
              _buildPersonalDataItem(
                icon: Icons.home,
                label: 'Dirección',
                value: 'Calle Mayor, 123, 1ºB, Madrid',
              ),
              const SizedBox(height: 24),
            ]),
          ),

          // ─────────────────────────────────────────────────────────────
          // 3) Sección: “Ajustes” que abre un Dialog al pulsar
          // ─────────────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListTile(
                leading: const Icon(Icons.settings, color: Colors.blueAccent),
                title: const Text('Ajustes', style: TextStyle(fontSize: 18)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // _showSettingsDialog(context);
                  showDialog(
                    context: context,
                    builder: (_) => const SettingsDialog(),
                  );
                },
              ),
            ),
          ),

          // Un poco de espacio extra abajo
          SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
      ),
    );
  }

  /// Helper para construir cada fila de “Datos Personales”
  Widget _buildPersonalDataItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }

  /// Muestra un diálogo para editar datos personales
  void _showEditPersonalDataDialog(BuildContext context) {
    // En una implementación real probablemente usarías un formulario
    // con TextFields para nombre, email, etc. Aquí mostramos un ejemplo simple.
    showDialog(
      context: context,
      builder: (_) {
        final TextEditingController nameController = TextEditingController(
          text: 'Carlos',
        );
        final TextEditingController surnameController = TextEditingController(
          text: 'Martínez',
        );
        final TextEditingController emailController = TextEditingController(
          text: 'carlos.martinez@techsolutions.com',
        );
        final TextEditingController phoneController = TextEditingController(
          text: '+34 612 345 678',
        );
        return AlertDialog(
          title: const Text('Editar Datos Personales'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: surnameController,
                  decoration: const InputDecoration(labelText: 'Apellido'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Teléfono'),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // cierra sin guardar
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Aquí guardas los cambios (p.ej., llamando a un Provider / ViewModel)
                // String newName = nameController.text; etc.
                Navigator.of(context).pop(); // cierra después de guardar
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}
