import 'package:flutterv1/features/events/data/datasources/event_data_source.dart';
import 'package:flutterv1/features/events/data/datasources/events_local_list.dart';

import '../models/event_model.dart';

class EventLocalDataSourceImpl implements EventDataSource {
  static final List<EventModel> _mock = mockEvents;

  @override
  Future<List<EventModel>> get allEvents async => _mock;

  @override
  Future<EventModel> getEventById(String id) async =>
      _mock.firstWhere((e) => e.id == id);

  @override
  Future<DateTime> get firstEverEvent async =>
      _mock
          .reduce((a, b) => (a.endDateTime).isBefore(b.endDateTime) ? a : b)
          .endDateTime;

  @override
  Future<DateTime> get lastEvent async =>
      _mock
          .reduce((a, b) => (a.endDateTime).isAfter(b.endDateTime) ? a : b)
          .endDateTime;

  @override
  Future<List<EventModel>> eventsByIds(List<String> ids) async =>
      Future.wait(ids.map((id) => getEventById(id)));
}
