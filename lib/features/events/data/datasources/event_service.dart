// import 'package:events_app/features/auth/data/datasources/auth_service.dart';
// import 'package:events_app/features/auth/domain/entities/user.dart';
// import 'package:events_app/features/events/data/datasources/events_data.dart';
// import 'package:events_app/features/events/data/models/event.dart';

// class EventService {
//   AuthService authService = AuthService();

//   /// Todos los eventos (mock)
//   List<Event> get allEvents => mockEvents;

//   /// Devuelve el usuario logeado (mock)
//   User get currentUser => authService.currentUser!;

//   /// Eventos visibles al usuario según rol
//   List<Event> get visibleEvents {
//     if (currentUser.role == Role.manager) {
//       return allEvents;
//     } else {
//       return allEvents
//           .where((e) => currentUser.registeredEventIds!.contains(e.id))
//           .toList();
//     }
//   }

//   /// El día más antiguo ya pasado (o hoy si no hay ninguno)
//   DateTime get firstAllowedDay {
//     final now = DateTime.now();
//     final pastDates =
//         visibleEvents
//             .where((e) => e.startDateTime.isBefore(now))
//             .map((e) => e.startDateTime)
//             .toList();
//     if (pastDates.isEmpty) return now;
//     return pastDates.reduce((a, b) => a.isBefore(b) ? a : b);
//   }

//   DateTime get lastAllowedDay {
//     final now = DateTime.now();
//     final futureDates =
//         visibleEvents
//             .where((e) => e.startDateTime.isAfter(now))
//             .map((e) => e.startDateTime)
//             .toList();
//     if (futureDates.isEmpty) return now;
//     return futureDates.reduce((a, b) => a.isAfter(b) ? a : b);
//   }

//   /// Suma horas de evento para mostrar remuneración total
//   double totalPayFor(Event e) =>
//       e.ratePerHour * e.endDateTime.difference(e.startDateTime).inHours;
// }
