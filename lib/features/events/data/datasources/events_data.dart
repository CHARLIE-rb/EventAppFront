import '../models/event.dart';

final List<Event> mockEvents = [
  Event(
    id: 'e1',
    title: 'Kick-off reunión',
    brand: 'ACME Corp.',
    startDateTime: DateTime(2025, 4, 05, 9, 0),
    endDateTime: DateTime(2025, 4, 05, 12, 0),
    locationName: 'Oficinas ACME, Madrid',
    latitude: 40.4168,
    longitude: -3.7038,
    mapUrl: 'https://www.google.com/maps?q=40.4168,-3.7038',
    functionDescription: 'Presentación de proyecto y recogida de feedback.',
    clothesDescription: 'Traje formal (americana y pantalón).',
    clothesImageUrl: 'assets/images/welcome.png',
    instructions: 'Llegar 15 min antes. Parking B.',
    ratePerHour: 25.0,

    companyFeedback: FeedBack(
      id: '0',
      rating: 4,
      comment: 'El evento fue muy productivo y bien organizado.',
      timestamp: DateTime(2025, 5, 20, 13, 0),
    ),
    employeeFeedbacks: [
      FeedBack(
        id: 'u1',
        rating: 5,
        comment: 'Me gustó mucho la dinámica',
        timestamp: DateTime(2025, 5, 20, 13, 0),
      ),
    ],
  ),

  Event(
    id: 'e2',
    title: 'Workshop Flutter',
    brand: 'DevStudios',
    startDateTime: DateTime(2025, 5, 22, 14, 0),
    endDateTime: DateTime(2025, 5, 22, 18, 0),
    locationName: 'Coworking Tech, BCN',
    latitude: 41.3874,
    longitude: 2.1686,
    mapUrl: 'https://www.google.com/maps?q=41.3874,2.1686',
    functionDescription: 'Taller de Flutter básico.',
    clothesDescription: 'Casual business.',
    clothesImageUrl: 'https://example.com/images/casual.png',
    instructions: 'Traer portátil con Flutter.',
    ratePerHour: 30.0,
    // aún no feedback porque es futuro
  ),

  // … otros eventos …
];
