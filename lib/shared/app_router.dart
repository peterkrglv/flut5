import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prac5/features/trp/cubit/trip_cubit.dart';

import '../features/authorization/screens/auth_screen.dart';
import '../features/home/home_screen.dart';
import '../features/transport/screens/transport_screen.dart';
import '../features/transport/сubit/transport_cubit.dart';
import '../features/trips_history/screens/trip_history_screen.dart';
import '../features/trips_history/сubit/trip_history_cubit.dart';
import '../features/trp/screens/trip_screen.dart';
import '../features/user_profile/cubit/user_cubit.dart';
import '../features/user_profile/screens/user_profile_screen.dart';
import 'eco_data_manager.dart';

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
        return BlocProvider<TripCubit>(
          create: (context) => TripCubit(),
          child: TripAddScreen(initialDistanceKm: initialDistance ?? 0.0),
        );
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) {
        final dataManager = context.read<EcoDataManager>();

        return BlocProvider<UserProfileCubit>(
          create: (context) => UserProfileCubit(dataManager),
          child: const UserProfileScreen(),
        );
      },
    ),
    GoRoute(
      path: '/history',
      builder: (context, state) {
        final dataManager = context.read<EcoDataManager>();
        return BlocProvider<TripHistoryCubit>(
          create: (context) => TripHistoryCubit(dataManager),
          child: const TripHistoryScreen(),
        );
      },
    ),
  ],
);