import 'package:flutterv1/features/events/data/models/event.dart';
import 'package:flutterv1/features/events/domain/repositories/event_repository.dart';

class GetAllEvents {
  final EventRepository eventRepository;
  GetAllEvents(this.eventRepository);
  Future<List<Event>> call() async {
    try {
      return await eventRepository.getAllEvents();
    } catch (e) {
      throw Exception('Failed to load events: $e');
    }
  }
}
