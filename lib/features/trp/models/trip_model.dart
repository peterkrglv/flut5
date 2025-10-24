class Trip {
  final String id;
  final DateTime date;
  final double distanceKm;
  final String transportName;
  final double carbonFootprintKg;

  const Trip({
    required this.id,
    required this.date,
    required this.distanceKm,
    required this.transportName,
    required this.carbonFootprintKg,
  });

  Trip copyWith({
    String? id,
    DateTime? date,
    double? distanceKm,
    String? transportName,
    double? carbonFootprintKg,
  }) {
    return Trip(
      id: id ?? this.id,
      date: date ?? this.date,
      distanceKm: distanceKm ?? this.distanceKm,
      transportName: transportName ?? this.transportName,
      carbonFootprintKg: carbonFootprintKg ?? this.carbonFootprintKg,
    );
  }
}