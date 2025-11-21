import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/eco_data_manager.dart';
import '../../trp/models/trip_model.dart';

class TripHistoryState {
  final List<TripModel> trips;

  const TripHistoryState({required this.trips});

  TripHistoryState copyWith({List<TripModel>? trips}) {
    return TripHistoryState(
      trips: trips ?? this.trips,
    );
  }
}


class TripHistoryCubit extends Cubit<TripHistoryState> {
  final EcoDataManager _dataManager;

  TripHistoryCubit(this._dataManager)
      : super(TripHistoryState(trips: _dataManager.trips.reversed.toList())) {

    _dataManager.addListener(_onDataManagerChanged);
  }

  void _onDataManagerChanged() {
    emit(state.copyWith(trips: _dataManager.trips.reversed.toList()));
  }

  void deleteTrip(int id) {
    _dataManager.deleteTrip(id);
  }

  @override
  Future<void> close() {
    _dataManager.removeListener(_onDataManagerChanged);
    return super.close();
  }
}