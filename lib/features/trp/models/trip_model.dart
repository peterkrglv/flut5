import 'package:prac5/features/transport/models/transport_model.dart';

class Trip {
  final String id;
  final DateTime date;
  final double distanceKm;
  final Transport transport;
  final double carbonFootprintKg;

  const Trip({
    required this.id,
    required this.date,
    required this.distanceKm,
    required this.transport,
    required this.carbonFootprintKg,
  });

  Trip copyWith({
    String? id,
    DateTime? date,
    double? distanceKm,
    Transport? transport,
    double? carbonFootprintKg,
  }) {
    return Trip(
      id: id ?? this.id,
      date: date ?? this.date,
      distanceKm: distanceKm ?? this.distanceKm,
      transport: transport ?? this.transport,
      carbonFootprintKg: carbonFootprintKg ?? this.carbonFootprintKg,
    );
  }
}