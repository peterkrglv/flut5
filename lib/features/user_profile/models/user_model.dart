import 'package:prac5/features/trp/models/trip_model.dart';

class UserProfile {
  final int totalTrips;
  final double totalCarbonKg;
  final String mostUsedTransport;
  final List<TripModel> trips;

  const UserProfile({
    required this.totalTrips,
    required this.totalCarbonKg,
    required this.mostUsedTransport,
    required this.trips,
  });

  UserProfile copyWith({
    int? totalTrips,
    double? totalCarbonKg,
    String? mostUsedTransport,
    List<TripModel>? trips,
  }) {
    return UserProfile(
      totalTrips: totalTrips ?? this.totalTrips,
      totalCarbonKg: totalCarbonKg ?? this.totalCarbonKg,
      mostUsedTransport: mostUsedTransport ?? this.mostUsedTransport,
      trips: trips ?? this.trips,
    );
  }
}