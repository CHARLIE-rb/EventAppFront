// di.dart  (o donde agrupas todos los módulos de DI)

import 'package:flutterv1/core/inyeccion_dependencias/companies/companies_di.dart';
import 'package:get_it/get_it.dart';

import 'package:flutterv1/core/inyeccion_dependencias/shared/shared_di.dart';
import 'package:flutterv1/core/inyeccion_dependencias/auth/auth_di.dart';
import 'package:flutterv1/core/inyeccion_dependencias/events/events_di.dart';

import 'package:flutterv1/features/theme/presentation/providers/theme_provider.dart';
import 'package:flutterv1/shared/presentation/providers/session_provider.dart';

import 'package:flutterv1/features/navigation/domain/usecases/get_nav_items.dart';
import 'package:flutterv1/features/navigation/presentation/providers/nav_notifier.dart';

final GetIt getIt = GetIt.instance;

/// Inicializa TODOS los módulos de tu app, SIN “espera manual” interna.
/// Al final, hacemos `await getIt.allReady()` para garantizar que:
///   • CredentialStorage haya terminado su init().
///   • SessionRepository se haya creado (depende de CredentialStorage).
///   • Todos los use‐cases de sesión (GetCurrentUser, Logout, etc.) se hayan creado.
///   • SessionProvider esté registrado.
///   • Todos los use‐cases de Auth (LoginWithEmail, etc.) se hayan creado.
///   • AuthProvider esté registrado.
///   • Los objetos de Events (repo, usecases, provider) estén registrados.
///   • GetNavItems y NavNotifier estén registrados (NavNotifier usa SessionProvider).
///   • CompanyDataSource, CompanyRepository y sus use‐cases estén registrados.
///   • CompaniesNotifier esté registrado.
/// Una vez que `allReady()` regrese, no habrá más dependencias “pendientes”.
Future<void> initDI() async {
  // ────────────────────────────────────────────────────────────────
  // 1) ThemeProvider (Factory) – no depende de nada más.
  // ────────────────────────────────────────────────────────────────
  getIt.registerFactory<ThemeProvider>(() => ThemeProvider());

  // ────────────────────────────────────────────────────────────────
  // 2) Módulo “Shared”: CredentialStorage, SessionRepository, UseCases de sesión, SessionProvider
  //    (aquí NO hacemos await, porque dejamos que `allReady()` encienda el orden completo).
  // ────────────────────────────────────────────────────────────────
  initSharedModule(getIt);

  // ────────────────────────────────────────────────────────────────
  // 3) Módulo “Auth”: UseCases de Auth y AuthProvider
  //    Como LoginWithEmail y LoginWithPin dependen de SessionRepository,
  //    GetIt esperará internamente a que SessionRepository (de Shared) esté listo.
  // ────────────────────────────────────────────────────────────────
  initAuthModule(getIt);

  // ────────────────────────────────────────────────────────────────
  // 4) Módulo “Events”
  // ────────────────────────────────────────────────────────────────
  initEventsModule(getIt);

  // ────────────────────────────────────────────────────────────────
  // 5) NAVIGATION
  //    – GetNavItems: singleton sin dependencia
  //    – NavNotifier (Factory) DEPENDE de GetNavItems y SessionProvider
  //      (SessionProvider viene de Shared, ya registrado)
  // ────────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<GetNavItems>(() => GetNavItems());
  getIt.registerFactory<NavNotifier>(
    () => NavNotifier(getIt<GetNavItems>(), getIt<SessionProvider>()),
  );
  initCompaniesModule(getIt);
  // ────────────────────────────────────────────────────────────────
  // 7) Finalmente, “enciende” la inicialización de todos los singletons
  //    asíncronos y con dependencias via `allReady()`. Esto bloquea hasta que:
  //      • CredentialStorage haya finalizado su init().
  //      • SessionRepository se haya construido.
  //      • Todos los use‐cases de sesión estén construidos.
  //      • SessionProvider esté registrado.
  //      • Todos los use‐cases de Auth estén construidos.
  //      • AuthProvider esté registrado.
  //      • Todos los objetos de Events estén registrados.
  //      • GetNavItems y NavNotifier estén registrados.
  //      • GetAllCompanies, DeleteCompany, UpdateCompany y CompaniesNotifier estén registrados.
  // ────────────────────────────────────────────────────────────────
  await getIt.allReady();
}
