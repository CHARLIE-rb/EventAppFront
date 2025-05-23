import 'package:flutterv1/features/events/domain/entities/event.dart';
import 'package:flutterv1/features/events/domain/repositories/event_repository.dart';

class GetEventsByIds {
  final EventRepository repository;

  GetEventsByIds(this.repository);

  Future<List<Event>> call(List<String> ids) async {
    return await repository.getEventsByIds(ids);
  }
}
