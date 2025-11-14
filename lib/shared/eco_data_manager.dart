import 'package:flutter/foundation.dart';
import 'package:prac5/features/transport/models/transport_model.dart';
import 'package:prac5/features/trp/models/trip_model.dart';
import 'package:prac5/features/user_profile/models/user_model.dart';
import 'package:uuid/uuid.dart';

class EcoDataManager extends ChangeNotifier {
  final List<TransportModel> availableTransports = getMockTransports();

  final List<TripModel> _trips = getMockTrips();

  UserProfileModel get userProfile => _calculateProfile();

  List<TripModel> get trips => _trips;

  final Uuid _uuid = const Uuid();

  void addTrip({
    required double distanceKm,
    required TransportModel transport,
    required double carbonFootprintKg,
  }) {
    final newTrip = TripModel(
      id: _uuid.v4(),
      date: DateTime.now(),
      distanceKm: distanceKm,
      transport: transport,
      carbonFootprintKg: carbonFootprintKg,
    );

    _trips.add(newTrip);

    notifyListeners();
  }

  void deleteTrip(String tripId) {
    _trips.removeWhere((trip) => trip.id == tripId);

    notifyListeners();
  }

  UserProfileModel _calculateProfile() {
    if (_trips.isEmpty) {
      return UserProfileModel(
        totalTrips: 0,
        totalCarbonKg: 0.0,
        mostUsedTransport: 'Нет данных',
        trips: _trips,
      );
    }

    final int totalTrips = _trips.length;
    final double totalCarbonKg = _trips.fold(0.0, (sum, item) => sum + item.carbonFootprintKg);

    final Map<String, int> transportCounts = {};
    for (var trip in _trips) {
      transportCounts[trip.transport.name] = (transportCounts[trip.transport.name] ?? 0) + 1;
    }

    String mostUsedTransport = 'Нет данных';
    int maxCount = 0;

    transportCounts.forEach((name, count) {
      if (count > maxCount) {
        maxCount = count;
        mostUsedTransport = name;
      }
    });

    return UserProfileModel(
      totalTrips: totalTrips,
      totalCarbonKg: totalCarbonKg,
      mostUsedTransport: mostUsedTransport,
      trips: _trips,
    );
  }
}
