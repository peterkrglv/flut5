import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:prac5/features/transport/models/transport_model.dart';
import 'package:prac5/shared/eco_data_manager.dart';
import '../cubit/trip_cubit.dart';

class TripAddScreen extends StatelessWidget {
  final double initialDistanceKm;
  final TextEditingController _distanceController = TextEditingController();

  TripAddScreen({
    super.key,
    required this.initialDistanceKm,
  });

  @override
  Widget build(BuildContext context) {
    final EcoDataManager dataManager = context.read<EcoDataManager>();
    final TripCubit tripCubit = context.read<TripCubit>();

    if (initialDistanceKm > 0 && _distanceController.text.isEmpty) {
      _distanceController.text = initialDistanceKm.toStringAsFixed(1);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        tripCubit.updateDistance(_distanceController.text);
      });
    }

    if (!_distanceController.hasListeners) {
      _distanceController.addListener(() {
        tripCubit.updateDistance(_distanceController.text);
      });
    }

    final transports = dataManager.availableTransports;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить поездку'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            _distanceController.removeListener(() => tripCubit.updateDistance(_distanceController.text));
            context.pop();
          },
        ),
      ),
      body: BlocBuilder<TripCubit, TripState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _distanceController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Пройденное расстояние (км)',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                DropdownButtonFormField<TransportModel>(
                  decoration: const InputDecoration(
                    labelText: 'Вид транспорта',
                    border: OutlineInputBorder(),
                  ),
                  value: state.selectedTransport,
                  items: transports.map((transport) {
                    return DropdownMenuItem<TransportModel>(
                      value: transport,
                      child: Row(
                        children: [
                          Icon(transport.iconData),
                          const SizedBox(width: 10),
                          Text(transport.name),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (TransportModel? newValue) {
                    tripCubit.updateTransport(newValue);
                  },
                ),

                const SizedBox(height: 30),

                FootprintResultCard(footprintKg: state.calculatedFootprintKg),

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: state.calculatedFootprintKg > 0 && state.selectedTransport != null
                      ? () {
                    dataManager.addTrip(
                      distanceKm: state.distanceKm,
                      transport: state.selectedTransport!,
                      carbonFootprintKg: state.calculatedFootprintKg,
                    );

                    tripCubit.resetState();
                    _distanceController.clear();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Поездка сохранена!')),
                    );
                  }
                      : null,
                  child: const Text('Сохранить поездку', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class FootprintResultCard extends StatelessWidget {
  final double footprintKg;

  const FootprintResultCard({
    required this.footprintKg,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const String iconUrl = "https://static.vecteezy.com/system/resources/previews/020/978/286/non_2x/carbon-dioxide-reduction-co2-emissions-gas-reduction-business-concept-isolated-illustration-vector.jpg";
    const double iconSize = 120.0;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: iconUrl,
              width: iconSize,
              height: iconSize,
              fit: BoxFit.contain,
              placeholder: (context, url) => SizedBox(
                width: iconSize,
                height: iconSize,
                child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.cloud_off, color: Colors.red, size: iconSize),
            ),

            const SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Расчитанный углеродный след:',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${footprintKg.toStringAsFixed(3)} кг CO₂',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}