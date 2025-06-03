import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterv1/core/inyeccion_dependencias/di.dart';
import 'package:flutterv1/features/events/presentation/widgets/details_card.dart';
import 'package:flutterv1/features/events/presentation/widgets/expandible_items_list.dart';
import 'package:flutterv1/shared/presentation/widgets/expandable_item.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:flutterv1/features/events/domain/entities/event.dart';
import '../providers/comments_notifier.dart';
import '../providers/events_details_notifier.dart'; // o el servicio si lo renombraste

class EventDetailScreen extends StatelessWidget {
  final Event event;
  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 1) Provider de comentarios
        ChangeNotifierProvider<CommentsNotifier>(
          create: (_) => getIt<CommentsNotifier>(param1: event),
        ),

        // 2) Provider para detalles (solo lectura)
        //    Si tu clase sigue siendo ChangeNotifier, usa ChangeNotifierProvider.
        //    Si ya la convertiste en servicio puro, use Provider<EventsDetailsNotifier>.
        ChangeNotifierProvider<EventsDetailsNotifier>(
          create: (_) => getIt<EventsDetailsNotifier>(param1: event.id),
        ),
      ],
      child: _EventDetailBody(event: event),
    );
  }
}

class _EventDetailBody extends StatefulWidget {
  final Event event;
  const _EventDetailBody({required this.event});
  @override
  State<_EventDetailBody> createState() => _EventDetailBodyState();
}

class _EventDetailBodyState extends State<_EventDetailBody> {
  double? _rating;
  String? _comment;
  late TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    // Inicializo el TextEditingController con el feedback actual (si existe)
    final vmComments = context.read<CommentsNotifier>();
    final me = vmComments.myFeedback;
    _rating = me?.rating.toDouble();
    _comment = me?.comment;
    _commentController = TextEditingController(text: _comment);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vmComments = context.watch<CommentsNotifier>();
    final vmDetails = context.read<EventsDetailsNotifier>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.event.title)),
      body: Column(
        children: [
          // — Detalles básicos del evento —
          Text(widget.event.brand, style: theme.textTheme.headlineSmall),
          const SizedBox(height: 12),
          DetailsCard(event: widget.event, theme: theme),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ejemplo: Mostrar lista de detalles “expandibles” usando vmDetails
                  FutureBuilder<List<ExpandableItem>>(
                    future: vmDetails.getAllEmployeeExpandibleItemsList(),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      final items = snapshot.data ?? [];
                      if (items.isEmpty) {
                        return const Center(
                          child: Text('No hay detalles para este evento.'),
                        );
                      }
                      return EventExpansionPanels(
                        employeeExpandibleItemsList: items,
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // — SECCIÓN DE FEEDBACK (Comentarios) —
                  if (vmComments.isManager) ...[
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => _EmployeeCommentsDialog(),
                        );
                      },
                      child: const Text('Ver feedback de empleados'),
                    ),
                  ] else if ((vmComments.isEmployee || vmComments.isCompany) &&
                      vmComments.isPastEvent &&
                      vmComments.within48h) ...[
                    Text('Tu feedback', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),
                    RatingBar.builder(
                      initialRating: _rating ?? 0,
                      minRating: 0.5,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 32,
                      itemBuilder:
                          (_, __) =>
                              const Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (r) => setState(() => _rating = r),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        labelText: 'Comentario (opcional)',
                      ),
                      onChanged: (t) => _comment = t,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed:
                          (_rating != null) && !vmComments.isLoading
                              ? () => vmComments.submitFeedback(
                                rating: _rating!.toInt(),
                                comment: _comment,
                              )
                              : null,
                      child:
                          vmComments.isLoading
                              ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                              : Text(
                                vmComments.myFeedback == null
                                    ? 'Enviar'
                                    : 'Actualizar',
                              ),
                    ),
                  ],

                  // — Feedback fijo tras 48h —
                  if (vmComments.isPastEvent && !vmComments.within48h) ...[
                    const Divider(),
                    if (widget.event.companyFeedback != null) ...[
                      Text(
                        'Feedback empresa',
                        style: theme.textTheme.titleMedium,
                      ),
                      ListTile(
                        leading: const Icon(Icons.business),
                        title: Text(
                          '${widget.event.companyFeedback!.rating}/5',
                        ),
                        subtitle: Text(widget.event.companyFeedback!.comment),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),
        ],
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
