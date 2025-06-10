// _event_employees_dialog.dart (opcional) ------------------------------
import 'package:events_app/shared/domain/entities/user.dart';
import 'package:flutter/material.dart';

class EventEmployeesDialog extends StatelessWidget {
  const EventEmployeesDialog({super.key, required this.futureUsers});

  final Future<List<User>?> futureUsers;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final width = mq.size.width * 0.7;
    final height = mq.size.height * 0.4;

    return AlertDialog(
      insetPadding: const EdgeInsets.all(24),
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Personal confirmado'),
      content: SizedBox(
        width: width,
        height: height,
        child: FutureBuilder<List<User>?>(
          future: futureUsers,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final employees = snapshot.data ?? [];
            if (employees.isEmpty) {
              return const Center(child: Text('No hay empleados asignados.'));
            }

            return Scrollbar(
              thumbVisibility: true,
              child: ListView.separated(
                itemCount: employees.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (_, i) {
                  final emp = employees[i];
                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(emp.name),
                    subtitle: Text(emp.role.name),
                  );
                },
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}
