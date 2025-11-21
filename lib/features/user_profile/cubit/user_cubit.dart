import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/eco_data_manager.dart';
import '../../trp/models/trip_model.dart';
import '../models/user_model.dart';

class UserProfileState {
  final UserProfileModel userProfile;

  const UserProfileState({required this.userProfile});

  UserProfileState copyWith({UserProfileModel? userProfile}) {
    return UserProfileState(
      userProfile: userProfile ?? this.userProfile,
    );
  }
}

class UserProfileCubit extends Cubit<UserProfileState> {
  final EcoDataManager _dataManager;

  UserProfileCubit(this._dataManager)
      : super(UserProfileState(userProfile: _calculateProfile(_dataManager.trips))) {

    _dataManager.addListener(_onDataManagerChanged);
  }

  void _onDataManagerChanged() {
    final newProfile = _calculateProfile(_dataManager.trips);
    emit(state.copyWith(userProfile: newProfile));
  }

  static UserProfileModel _calculateProfile(List<TripModel> trips) {
    if (trips.isEmpty) {
      return UserProfileModel(
        totalTrips: 0,
        totalCarbonKg: 0.0,
        mostUsedTransport: 'Нет данных',
        trips: trips,
      );
    }

    final int totalTrips = trips.length;
    final double totalCarbonKg = trips.fold(0.0, (sum, item) => sum + item.carbonFootprintKg);

    final Map<String, int> transportCounts = {};
    for (var trip in trips) {
      transportCounts[trip.transport.name] = (transportCounts[trip.transport.name] ?? 0) + 1;
    }

    String mostUsedTransport = 'Нет данных';
    int maxCount = 0;

    transportCounts.forEach((name, count) {
      if (count > maxCount) {
        maxCount = count;
        mostUsedTransport = name;
      }
    });

    return UserProfileModel(
      totalTrips: totalTrips,
      totalCarbonKg: totalCarbonKg,
      mostUsedTransport: mostUsedTransport,
      trips: trips,
    );
  }

  @override
  Future<void> close() {
    _dataManager.removeListener(_onDataManagerChanged);
    return super.close();
  }
}