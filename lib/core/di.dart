
// DataSource
getIt.registerLazySingleton<EventRemoteDataSource>(
  () => EventRemoteDataSourceImpl(getIt()));
// Local (mock) DataSource
getIt.registerLazySingleton<EventLocalDataSource>(
  () => EventsLocalDataSourceImpl());
// Repository
getIt.registerLazySingleton<EventRepository>(
  () => EventRepositoryImpl(getIt(), getIt()));
// UseCase
getIt.registerLazySingleton(() => GetAllEvents(getIt()));
// Provider / Notifier
getIt.registerFactory(() => EventsNotifier(getIt()));
