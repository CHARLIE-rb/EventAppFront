import 'package:events_app/features/events/data/datasources/forWidgets/event_widget_datasource.dart';
import 'package:events_app/features/events/data/datasources/forWidgets/local_event_widget_datasource.dart';
import 'package:events_app/features/events/data/repositories/event_widget_repository_impl.dart';
import 'package:events_app/features/events/domain/repositories/event_widget_repository.dart';
import 'package:events_app/features/events/domain/usecases/forWidgets/get_all_employee_expandible_items_list.dart';
import 'package:events_app/features/events/presentation/providers/events_details_notifier.dart';
import 'package:events_app/shared/domain/usecases/users/get_users_by_ids.dart';
import 'package:get_it/get_it.dart';

void initEventsWidgetsModule(GetIt getIt) {
  getIt.registerLazySingleton<EventWidgetDataSource>(
    () => EventWidgetDataSourceImpl(),
  );
  getIt.registerLazySingleton<EventWidgetRepository>(
    () => EventWidgetRepositoryImpl(getIt<EventWidgetDataSource>()),
  );
  getIt.registerLazySingleton(
    () => GetAllEmployeeExpandibleItemsList(getIt<EventWidgetRepository>()),
  );
  getIt.registerFactory(
    () => EventsDetailsNotifier(
      getIt<GetAllEmployeeExpandibleItemsList>(),
      getIt<GetUsersByIds>(),
    ),
  );
}
