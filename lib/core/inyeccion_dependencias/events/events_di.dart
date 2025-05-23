import 'package:flutterv1/features/events/data/datasources/event_data_source.dart';
import 'package:flutterv1/features/events/data/datasources/events_local_data_source.dart';
import 'package:flutterv1/features/events/data/mappers/event_mapper.dart';
import 'package:flutterv1/features/events/data/repositories/event_repository_impl.dart';
import 'package:flutterv1/features/events/domain/repositories/event_repository.dart';
import 'package:flutterv1/features/events/domain/usecases/get_all_events.dart';
import 'package:flutterv1/features/events/domain/usecases/get_event_by_id.dart';
import 'package:flutterv1/features/events/domain/usecases/get_events_by_ids.dart';
import 'package:flutterv1/features/events/domain/usecases/get_first_ever_event.dart';
import 'package:flutterv1/features/events/domain/usecases/get_last_event.dart';
import 'package:flutterv1/features/events/domain/usecases/get_total_pay_for_event.dart';
import 'package:flutterv1/features/events/presentation/providers/events_notifier.dart';
import 'package:get_it/get_it.dart';

void initEventsModule(GetIt getIt) {
  // EVENTS
  getIt.registerLazySingleton<EventDataSource>(
    () => EventLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<EventMapper>(() => EventMapperImpl());
  getIt.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton(() => GetAllEvents(getIt()));
  getIt.registerLazySingleton(() => GetEventById(getIt()));
  getIt.registerLazySingleton(() => GetEventsByIds(getIt()));
  getIt.registerLazySingleton(() => GetFirstEverEvent(getIt()));
  getIt.registerLazySingleton(() => GetLastEvent(getIt()));
  getIt.registerLazySingleton(() => GetTotalPayForEvent(getIt()));

  getIt.registerFactory(
    () => EventsNotifier(getIt(), getIt(), getIt(), getIt(), getIt(), getIt()),
  );
}
