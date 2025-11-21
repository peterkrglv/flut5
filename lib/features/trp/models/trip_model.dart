import 'package:prac5/features/transport/models/transport_model.dart';

class TripModel {
  final int id;
  final DateTime date;
  final double distanceKm;
  final TransportModel transport;
  final double carbonFootprintKg;

  const TripModel({
    required this.id,
    required this.date,
    required this.distanceKm,
    required this.transport,
    required this.carbonFootprintKg,
  });

  TripModel copyWith({
    int? id,
    DateTime? date,
    double? distanceKm,
    TransportModel? transport,
    double? carbonFootprintKg,
  }) {
    return TripModel(
      id: id ?? this.id,
      date: date ?? this.date,
      distanceKm: distanceKm ?? this.distanceKm,
      transport: transport ?? this.transport,
      carbonFootprintKg: carbonFootprintKg ?? this.carbonFootprintKg,
    );
  }
}

List<TripModel> getMockTripHistory() {
  final transports = getMockTransports();
  return [
    TripModel(
      id: 1,
      date: DateTime.now().subtract(const Duration(days: 2)),
      distanceKm: 45.5,
      transport: transports[0],
      carbonFootprintKg: 45.5 * transports[0].co2PerKm / 1000,
    ),
    TripModel(
      id: 2,
      date: DateTime.now().subtract(const Duration(days: 5)),
      distanceKm: 12.0,
      transport: transports[1],
      carbonFootprintKg: 12.0 * transports[1].co2PerKm / 1000,
    ),
    TripModel(
      id: 3,
      date: DateTime.now().subtract(const Duration(days: 10)),
      distanceKm: 2.5,
      transport: transports[2],
      carbonFootprintKg: 2.5 * transports[2].co2PerKm / 1000,
    ),
    TripModel(
      id: 4,
      date: DateTime.now().subtract(const Duration(days: 15)),
      distanceKm: 150.0,
      transport: transports[0],
      carbonFootprintKg: 150.0 * transports[0].co2PerKm / 1000,
    ),
  ];
}