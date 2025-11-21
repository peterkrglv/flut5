import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../models/transport_model.dart';

class TransportState {
  final List<TransportModel> transports;

  const TransportState({required this.transports});

  TransportState copyWith({List<TransportModel>? transports}) {
    return TransportState(
      transports: transports ?? this.transports,
    );
  }
}


class TransportCubit extends Cubit<TransportState> {
  int _nextId = 11;

  TransportCubit() : super(TransportState(transports: getMockTransports()));

  void addTransport(String name, IconData icon, double co2) {
    final newTransport = TransportModel(
      id: _nextId++,
      name: name,
      iconData: icon,
      co2PerKm: co2,
      isUserAdded: true,
    );

    final updatedList = List<TransportModel>.from(state.transports)
      ..add(newTransport);

    emit(state.copyWith(transports: updatedList));
  }

  void removeTransport(int id) {
    final transportToRemove = state.transports.firstWhere((t) => t.id == id);

    if (transportToRemove.isUserAdded) {
      final updatedList = List<TransportModel>.from(state.transports)
        ..removeWhere((t) => t.id == id);

      emit(state.copyWith(transports: updatedList));
    } else {
      print('Попытка удалить общий транспорт: ${transportToRemove.name} (Запрещено)');
    }
  }
}