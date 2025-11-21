import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/authorization/screens/auth_screen.dart';
import '../features/home/home_screen.dart';
import '../features/transport/screens/transport_screen.dart';
import '../features/transport/сubit/transport_cubit.dart';
import '../features/trips_history/screens/trip_history_screen.dart';
import '../features/trp/screens/trip_screen.dart';
import '../features/user_profile/screens/user_profile_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const AuthorizationScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(appName: "CarbonTrack App",),
    ),
    GoRoute(
      path: '/transports-compare',
      builder: (context, state) {
        return BlocProvider<TransportCubit>(
          create: (context) => TransportCubit(),
          child: const TransportScreen(),
        );
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