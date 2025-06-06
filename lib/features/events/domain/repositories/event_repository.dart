import 'package:events_app/features/events/domain/entities/event.dart';

abstract class EventRepository {
  Future<List<Event>> get allEvents;
  Future<Event> getEventById(String id);
  Future<List<Event>> getEventsByIds(List<String> ids);
  Future<DateTime> get firstEverEvent;
  Future<DateTime> get lastEvent;
}
