import 'package:prac5/features/trp/models/trip_model.dart';

class UserProfileModel {
  final int totalTrips;
  final double totalCarbonKg;
  final String mostUsedTransport;
  final List<TripModel> trips;

  const UserProfileModel({
    required this.totalTrips,
    required this.totalCarbonKg,
    required this.mostUsedTransport,
    required this.trips,
  });

  UserProfileModel copyWith({
    int? totalTrips,
    double? totalCarbonKg,
    String? mostUsedTransport,
    List<TripModel>? trips,
  }) {
    return UserProfileModel(
      totalTrips: totalTrips ?? this.totalTrips,
      totalCarbonKg: totalCarbonKg ?? this.totalCarbonKg,
      mostUsedTransport: mostUsedTransport ?? this.mostUsedTransport,
      trips: trips ?? this.trips,
    );
  }
}