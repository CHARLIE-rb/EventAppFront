import 'package:events_app/features/events/domain/repositories/event_repository.dart';

class GetLastEvent {
  final EventRepository eventRepository;

  GetLastEvent(this.eventRepository);

  Future<DateTime> call() async => await eventRepository.lastEvent;
}
