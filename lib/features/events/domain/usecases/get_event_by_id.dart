import 'package:flutterv1/features/events/data/models/event.dart';
import 'package:flutterv1/features/events/domain/repositories/event_repository.dart';

class GetEventById {
  final EventRepository repository;

  GetEventById(this.repository);

  Future<Event> call(String id) async {
    return await repository.getEventById(id);
  }
}
