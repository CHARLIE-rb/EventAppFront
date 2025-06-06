import 'package:events_app/features/events/data/models/event_model.dart';

abstract class EventDataSource {
  Future<List<EventModel>> get allEvents;
  Future<List<EventModel>> eventsByIds(List<String> ids);
  Future<EventModel> getEventById(String id);
  Future<DateTime> get firstEverEvent;
  Future<DateTime> get lastEvent;
}
