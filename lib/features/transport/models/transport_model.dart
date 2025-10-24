import 'package:flutter/material.dart';

class TransportModel {
  final int id;
  final String name;
  final IconData iconData;
  final double co2PerKm;

  const TransportModel({
    required this.id,
    required this.name,
    required this.iconData,
    required this.co2PerKm,
  });

  TransportModel copyWith({
    int? id,
    String? name,
    IconData? iconData,
    double? co2PerKm,
  }) {
    return TransportModel(
      id: id ?? this.id,
      name: name ?? this.name,
      iconData: iconData ?? this.iconData,
      co2PerKm: co2PerKm ?? this.co2PerKm,
    );
  }
}


List<TransportModel> getMockTransports() {
  return [
    const TransportModel(
      id: 1,
      name: 'Автомобиль',
      iconData: Icons.directions_car,
      co2PerKm: 170.0,
    ),
    const TransportModel(
      id: 2,
      name: 'Электромобиль',
      iconData: Icons.electric_car,
      co2PerKm: 2.0,
    ),
    const TransportModel(
      id: 3,
      name: 'Городской автобус',
      iconData: Icons.directions_bus,
      co2PerKm: 105.0,
    ),
    const TransportModel(
      id: 4,
      name: 'Метро',
      iconData: Icons.subway,
      co2PerKm: 6.0,
    ),
    const TransportModel(
      id: 5,
      name: 'Пригородный поезд',
      iconData: Icons.train,
      co2PerKm: 40.0,
    ),
    const TransportModel(
      id: 6,
      name: 'Высокоскоростной поезд',
      iconData: Icons.directions_railway,
      co2PerKm: 15.0,
    ),
    const TransportModel(
      id: 7,
      name: 'Самолет',
      iconData: Icons.airplanemode_active,
      co2PerKm: 285.0,
    ),
    const TransportModel(
      id: 8,
      name: 'Электросамокат',
      iconData: Icons.electric_scooter,
      co2PerKm: 10.0,
    ),
    const TransportModel(
      id: 9,
      name: 'Велосипед',
      iconData: Icons.directions_bike,
      co2PerKm: 0.0,
    ),
    const TransportModel(
      id: 10,
      name: 'Пешком',
      iconData: Icons.directions_walk,
      co2PerKm: 0.0,
    ),
  ];
}