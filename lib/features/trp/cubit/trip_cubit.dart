import 'package:flutter_bloc/flutter_bloc.dart';

import '../../transport/models/transport_model.dart';

class TripState {
  final TransportModel? selectedTransport;
  final double distanceKm;
  final double calculatedFootprintKg;

  const TripState({
    this.selectedTransport,
    this.distanceKm = 0.0,
    this.calculatedFootprintKg = 0.0,
  });

  TripState copyWith({
    TransportModel? selectedTransport,
    double? distanceKm,
    double? calculatedFootprintKg,
  }) {
    return TripState(
      selectedTransport: selectedTransport ?? this.selectedTransport,
      distanceKm: distanceKm ?? this.distanceKm,
      calculatedFootprintKg: calculatedFootprintKg ?? this.calculatedFootprintKg,
    );
  }
}


class TripCubit extends Cubit<TripState> {
  TripCubit() : super(const TripState());

  void _calculateAndEmit(double distance, TransportModel? transport) {
    double footprint = 0.0;
    if (transport != null && distance > 0) {
      footprint = distance * transport.co2PerKm / 1000;
    }

    emit(state.copyWith(
      distanceKm: distance,
      selectedTransport: transport,
      calculatedFootprintKg: footprint,
    ));
  }

  void updateDistance(String distanceText) {
    final double distance = double.tryParse(distanceText) ?? 0.0;
    _calculateAndEmit(distance, state.selectedTransport);
  }

  void updateTransport(TransportModel? transport) {
    _calculateAndEmit(state.distanceKm, transport);
  }

  void resetState() {
    emit(const TripState());
  }
}