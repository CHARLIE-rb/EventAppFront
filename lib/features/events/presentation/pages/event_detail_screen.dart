import 'package:events_app/features/events/presentation/widgets/event_details_employees.dart';
import 'package:events_app/shared/presentation/widgets/mini/fabutton_aligned_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:events_app/core/inyeccion_dependencias/di.dart';
import 'package:events_app/features/events/presentation/widgets/details_card.dart';
import 'package:events_app/features/events/presentation/widgets/expandible_items_list.dart';
import 'package:events_app/shared/presentation/widgets/expandable_item.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:events_app/features/events/domain/entities/event.dart';
import '../providers/comments_notifier.dart';
import '../providers/events_details_notifier.dart';

class EventDetailScreen extends StatelessWidget {
  final Event event;
  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CommentsNotifier>(
          create: (_) => getIt<CommentsNotifier>(param1: event),
        ),

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
  late final ValueNotifier<double?> _ratingNotifier;
  String? _comment;
  late TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    final me = context.read<CommentsNotifier>().myFeedback;

    _ratingNotifier = ValueNotifier<double?>(me?.rating.toDouble() ?? 0);
    _comment = me?.comment;
    _commentController = TextEditingController(text: _comment);
  }

  @override
  void dispose() {
    _ratingNotifier.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vmComments = context.watch<CommentsNotifier>();
    final vmDetails = context.read<EventsDetailsNotifier>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.event.brand,
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.people),
            style: IconButton.styleFrom(
              foregroundColor: theme.colorScheme.primary,
              iconSize: 30,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (_) => EventEmployeesDialog(
                      futureUsers: vmDetails.getUsersByIds(
                        widget.event.employeesIds,
                      ),
                    ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FaButtonAlignedToAppBar(),
      body: Column(
        children: [
          Text(widget.event.title, style: theme.textTheme.headlineSmall),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(16),
            child: DetailsCard(event: widget.event, theme: theme),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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

                  if (vmComments.isManager && !vmComments.within48h) ...[
                    ElevatedButton(
                      onPressed: () {
                        // showDialog(
                        //   context: context,
                        // builder: (_) => _EmployeeCommentsDialog(),
                        // );
                      },
                      child: const Text('Ver feedback de empleados'),
                    ),
                  ] else if ((vmComments.isEmployee || vmComments.isCompany) &&
                      vmComments.within48h) ...[
                    Text('Tu feedback', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),
                    ValueListenableBuilder<double?>(
                      valueListenable: _ratingNotifier,
                      builder: (_, rating, __) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RatingBar.builder(
                              initialRating: rating ?? 0,
                              minRating: 0.5,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 32,
                              itemBuilder:
                                  (_, __) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                              onRatingUpdate: (r) => _ratingNotifier.value = r,
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
                                  (rating != null) &&
                                          !context
                                              .read<CommentsNotifier>()
                                              .isLoading
                                      ? () => context
                                          .read<CommentsNotifier>()
                                          .submitFeedback(
                                            rating: rating.toInt(),
                                            comment: _comment,
                                          )
                                      : null,
                              child:
                                  context.watch<CommentsNotifier>().isLoading
                                      ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                      : Text(
                                        context
                                                    .read<CommentsNotifier>()
                                                    .myFeedback ==
                                                null
                                            ? 'Enviar'
                                            : 'Actualizar',
                                      ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],

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
