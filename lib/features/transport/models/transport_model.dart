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