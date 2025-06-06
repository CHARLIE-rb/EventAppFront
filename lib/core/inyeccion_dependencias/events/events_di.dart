import 'package:events_app/core/inyeccion_dependencias/events/events_widgets_di.dart';
import 'package:events_app/features/events/data/datasources/event_data_source.dart';
import 'package:events_app/features/events/data/datasources/events_local_data_source.dart';
import 'package:events_app/features/events/data/mappers/event_mapper.dart';
import 'package:events_app/features/events/data/repositories/event_repository_impl.dart';
import 'package:events_app/features/events/domain/entities/event.dart';
import 'package:events_app/features/events/domain/repositories/event_repository.dart';
import 'package:events_app/features/events/domain/usecases/get_all_events.dart';
import 'package:events_app/features/events/domain/usecases/get_event_by_id.dart';
import 'package:events_app/features/events/domain/usecases/get_events_by_ids.dart';
import 'package:events_app/features/events/domain/usecases/get_first_ever_event.dart';
import 'package:events_app/features/events/domain/usecases/get_last_event.dart';
import 'package:events_app/features/events/domain/usecases/get_total_pay_for_event.dart';
import 'package:events_app/features/events/presentation/providers/comments_notifier.dart';
import 'package:events_app/features/events/presentation/providers/events_notifier.dart';
import 'package:events_app/shared/domain/usecases/session/get_current_user.dart';
import 'package:get_it/get_it.dart';

Future<void> initEventsModule(GetIt getIt) async {
  getIt.registerLazySingleton<EventDataSource>(
    () => EventLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<EventMapper>(() => EventMapperImpl());
  getIt.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton(() => GetAllEvents(getIt()));
  getIt.registerLazySingleton(() => GetFirstEverEvent(getIt()));
  getIt.registerLazySingleton(() => GetLastEvent(getIt()));
  getIt.registerLazySingleton(() => GetEventById(getIt()));
  getIt.registerLazySingleton(() => GetTotalPayForEvent(getIt()));
  getIt.registerLazySingleton(() => GetEventsByIds(getIt()));

  getIt.registerFactory(
    () => EventsNotifier(
      getIt<GetAllEvents>(),
      getIt<GetFirstEverEvent>(),
      getIt<GetLastEvent>(),
      getIt<GetEventById>(),
      getIt<GetTotalPayForEvent>(),
      getIt<GetEventsByIds>(),
    ),
  );

  getIt.registerFactoryParam<CommentsNotifier, Event, void>((event, _) {
    // Obtenemos la instancia del caso de uso
    final getCurrentUser = getIt<GetCurrentUser>();
    // Creamos el CommentsNotifier pasándole el Event y el GetCurrentUser
    return CommentsNotifier(event, getCurrentUser);
  });

  initEventsWidgetsModule(getIt);
}
