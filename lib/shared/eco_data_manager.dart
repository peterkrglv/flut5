import 'package:flutter/foundation.dart';
import 'package:prac5/features/transport/models/transport_model.dart';
import 'package:prac5/features/trp/models/trip_model.dart';
import 'package:prac5/features/user_profile/models/user_model.dart';

class EcoDataManager extends ChangeNotifier {
  final List<TransportModel> availableTransports = getMockTransports();

  final List<TripModel> _trips = getMockTripHistory();

  int _nextTripId = 5;

  List<TripModel> get trips => _trips;

  void addTrip({
    required double distanceKm,
    required TransportModel transport,
    required double carbonFootprintKg,
  }) {
    final newTrip = TripModel(
      id: _nextTripId++,
      date: DateTime.now(),
      distanceKm: distanceKm,
      transport: transport,
      carbonFootprintKg: carbonFootprintKg,
    );

    _trips.add(newTrip);

    notifyListeners();
  }

  void deleteTrip(int tripId) {
    _trips.removeWhere((trip) => trip.id == tripId);

    notifyListeners();
  }
}