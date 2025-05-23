// lib/features/events/presentation/pages/event_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterv1/core/inyeccion_dependencias/di.dart';
import 'package:flutterv1/features/auth/domain/entities/user.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:flutterv1/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutterv1/features/events/domain/entities/event.dart';
import '../providers/comments_notifier.dart';

class EventDetailScreen extends StatelessWidget {
  final Event event;
  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>();
    return ChangeNotifierProvider<CommentsNotifier>(
      create: (_) => getIt<CommentsNotifier>(param1: event),
      child: _EventDetailBody(event: event, currentUser: auth.user!),
    );
  }
}

class _EventDetailBody extends StatefulWidget {
  final Event event;
  final User currentUser;
  const _EventDetailBody({required this.event, required this.currentUser});
  @override
  State<_EventDetailBody> createState() => _EventDetailBodyState();
}

class _EventDetailBodyState extends State<_EventDetailBody> {
  double? _rating;
  String? _comment;

  @override
  void initState() {
    super.initState();
    final vm = context.read<CommentsNotifier>();
    final me = vm.myFeedback;
    if (me != null) {
      _rating = me.rating.toDouble();
      _comment = me.comment;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CommentsNotifier>();
    final theme = Theme.of(context);
    final dfDate = DateFormat.yMMMMd(
      Localizations.localeOf(context).toString(),
    );
    final dfTime = DateFormat.Hm();

    // Cálculos de precios y duración...
    final hours =
        widget.event.endDateTime.difference(widget.event.startDateTime).inHours;
    final totalPrice = widget.event.ratePerHour * hours;

    return Scaffold(
      appBar: AppBar(title: Text(widget.event.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // — Detalles básicos (igual que antes) —
            Text(widget.event.brand, style: theme.textTheme.headlineSmall),
            const SizedBox(height: 12),

            // aquí tu DetailsCard y ExpandibleItemsList…
            const SizedBox(height: 24),

            // — SECCIÓN DE FEEDBACK —
            if (vm.isManager) ...[
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => _EmployeeCommentsDialog(),
                  );
                },
                child: const Text('Ver feedback de empleados'),
              ),
            ] else if ((vm.isEmployee || vm.isCompany) &&
                vm.isPastEvent &&
                vm.within48h) ...[
              Text('Tu feedback', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              RatingBar.builder(
                initialRating: _rating ?? 0,
                minRating: 0.5,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 32,
                itemBuilder:
                    (_, __) => const Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (r) => setState(() => _rating = r),
              ),
              TextField(
                controller: TextEditingController(text: _comment),
                decoration: const InputDecoration(
                  labelText: 'Comentario (opcional)',
                ),
                onChanged: (t) => _comment = t,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed:
                    (_rating != null) && !vm.isLoading
                        ? () => vm.submitFeedback(
                          rating: _rating!.toInt(),
                          comment: _comment,
                        )
                        : null,
                child:
                    vm.isLoading
                        ? const CircularProgressIndicator()
                        : Text(vm.myFeedback == null ? 'Enviar' : 'Actualizar'),
              ),
            ],

            // — Feedback fijo tras 48h —
            if (vm.isPastEvent && !vm.within48h) ...[
              const Divider(),
              if (widget.event.companyFeedback != null) ...[
                Text('Feedback empresa', style: theme.textTheme.titleMedium),
                ListTile(
                  leading: const Icon(Icons.business),
                  title: Text('${widget.event.companyFeedback!.rating}/5'),
                  subtitle: Text(widget.event.companyFeedback!.comment),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

/// Dialog que muestra todos los comentarios de empleados
class _EmployeeCommentsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CommentsNotifier>();
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 400,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Feedback Empleados',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: vm.employeeComments.length,
                itemBuilder: (_, i) {
                  final fb = vm.employeeComments[i];
                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text('${fb.rating}/5'),
                    subtitle: Text(fb.comment),
                    trailing: Text(DateFormat.Hm().format(fb.timestamp)),
                  );
                },
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        ),
      ),
    );
  }
}
