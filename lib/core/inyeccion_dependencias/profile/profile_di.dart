import 'package:events_app/features/profile/data/datasources/profile_screen_items_datasource.dart';
import 'package:events_app/features/profile/data/datasources/profile_screen_items_lists.dart';
import 'package:events_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:events_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:events_app/features/profile/domain/usecases/get_profile_screen_items.dart';
import 'package:events_app/features/profile/presentation/providers/profile_provider.dart';
import 'package:get_it/get_it.dart';

void initProfileModule(GetIt getIt) {
  getIt.registerLazySingleton<ProfileScreenItems>(() => ProfileScreenItems());
  getIt.registerLazySingleton<ProfileScreenItemsDatasource>(
    () => ProfileScreenItemsDatasource(getIt<ProfileScreenItems>()),
  );
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt<ProfileScreenItemsDatasource>()),
  );
  getIt.registerLazySingleton<GetProfileScreenItems>(
    () => GetProfileScreenItems(getIt<ProfileRepository>()),
  );
  getIt.registerFactory<ProfileProvider>(
    () => ProfileProvider(getIt<GetProfileScreenItems>()),
  );
}
