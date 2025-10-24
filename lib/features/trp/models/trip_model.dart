import 'package:prac5/features/transport/models/transport_model.dart';

class TripModel {
  final String id;
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
    String? id,
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