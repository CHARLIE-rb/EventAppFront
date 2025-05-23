import 'package:flutterv1/features/events/data/models/event.dart';

abstract class EventRepository {
  Future<List<Event>> getAllEvents();
  Future<Event> getEventById(String id);
}
