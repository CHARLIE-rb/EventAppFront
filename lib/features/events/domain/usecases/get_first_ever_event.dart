import 'package:flutterv1/features/events/domain/repositories/event_repository.dart';

class GetFirstEverEvent {
  final EventRepository repository;

  GetFirstEverEvent(this.repository);

  Future<DateTime> call() async => await repository.firstEverEvent;
}
