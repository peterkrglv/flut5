import 'package:go_router/go_router.dart';
import '../features/transport/models/transport_model.dart';
import '../features/transport/screens/transport_screen.dart';
import '../features/trips_history/screens/trip_history_screen.dart';
import '../features/trp/screens/trip_screen.dart';
import '../features/user_profile/screens/user_profile_screen.dart';
import '../main.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        final appName = state.extra as String;
        return HomeScreen(appName: appName);
      },
    ),
    GoRoute(
      path: '/transports-compare',
      builder: (context, state) {
        final transports = state.extra as List<TransportModel>;
        return TransportScreen(transports: transports);
      },
    ),
    GoRoute(
      path: '/add-trip',
      builder: (context, state) {
        final initialDistance = state.extra as double?;
        return TripAddScreen(initialDistanceKm: initialDistance ?? 0.0);
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const UserProfileScreen(),
    ),
    GoRoute(
      path: '/history',
      builder: (context, state) => const TripHistoryScreen(),
    ),
  ],
);