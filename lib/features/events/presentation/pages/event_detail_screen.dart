import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterv1/src/models/role.dart';
import 'package:flutterv1/src/widgets/event_detail_widgets/details_card.dart';
import 'package:flutterv1/src/widgets/event_detail_widgets/expandible_items_list.dart';
import 'package:intl/intl.dart';

import '../../models/event.dart';
import '../../services/event_service.dart';

class EventDetailScreen extends StatefulWidget {
  final Event event;
  const EventDetailScreen({super.key, required this.event});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  final _svc = EventService();

  double? _myRating;
  String? _myComment;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    int i = 0;
    while (i < widget.event.employeeFeedbacks.length &&
        widget.event.employeeFeedbacks[i].id != _svc.currentUser.id) {
      i++;
    }
    if (i < widget.event.employeeFeedbacks.length) {
      FeedBack existing = widget.event.employeeFeedbacks[i];
      _myRating = existing.rating.toDouble();
      _myComment = existing.comment;
      _submitted = true;
      existing = widget.event.employeeFeedbacks[i];
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final e = widget.event;
    final now = DateTime.now();
    final isPast = DateUtils.dateOnly(
      now,
    ).isAfter(DateUtils.dateOnly(e.endDateTime));
    final within48h =
        now.isAfter(e.endDateTime) &&
        now.isBefore(e.endDateTime.add(Duration(hours: 48)));
    final isEmployee = _svc.currentUser.role != Role.manager;

    return Scaffold(
      appBar: AppBar(title: Text(e.brand, style: TextStyle(fontSize: 22))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              e.title,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            DetailsCard(event: e, theme: theme),
            SizedBox(height: 16),
            EventExpansionPanels(),
            SizedBox(height: 24),
            if (!isPast)
              if (isEmployee && within48h) ...[
                Text(
                  'Tu feedback',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8),

                RatingBar.builder(
                  initialRating: _myRating ?? 0,
                  minRating: 0.5,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 32,
                  itemBuilder: (_, __) => Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (r) {
                    setState(() => _myRating = r);
                  },
                ),

                TextField(
                  controller: TextEditingController(text: _myComment),
                  decoration: InputDecoration(
                    labelText: 'Comentario (opcional)',
                  ),
                  onChanged: (t) => _myComment = t,
                ),

                SizedBox(height: 8),
                ElevatedButton(
                  onPressed:
                      (_myRating != null && !_submitted)
                          ? () {
                            setState(() {
                              widget.event.employeeFeedbacks.add(
                                FeedBack(
                                  id: _svc.currentUser.id,
                                  rating: _myRating!.toInt(),
                                  comment: _myComment ?? '',
                                  timestamp: DateTime.now(),
                                ),
                              );
                              _submitted = true;
                            });
                          }
                          : null,
                  child: Text(_submitted ? 'Enviado' : 'Enviar feedback'),
                ),
              ],

            // — FEEDBACK FIJO tras 48h o si ya estaba enviado —
            if (isPast && !within48h) ...[
              if (e.employeeFeedbacks.isNotEmpty) ...[
                Divider(),
                Text(
                  'Feedback',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                ...e.employeeFeedbacks.map(
                  (fb) => ListTile(
                    leading: Icon(Icons.person),
                    title: Text('${fb.rating}/5'),
                    subtitle: Text(fb.comment),
                    trailing: Text(DateFormat.Hm().format(fb.timestamp)),
                  ),
                ),
              ],

              if (e.companyFeedback != null) ...[
                Divider(),
                ListTile(
                  leading: Icon(Icons.business),
                  title: Text(
                    'Feedback empresa: ${e.companyFeedback!.rating}/5',
                  ),
                  subtitle: Text(e.companyFeedback?.comment ?? ''),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
