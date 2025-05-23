import 'package:flutterv1/features/events/domain/repositories/event_repository.dart';

class GetTotalPayForEvent {
  final EventRepository eventRepository;

  GetTotalPayForEvent(this.eventRepository);
  Future<double> call(String eventId) async {
    final event = await eventRepository.getEventById(eventId);
    return event.ratePerHour *
        (event.endDateTime.difference(event.startDateTime)).inHours;
  }
}
