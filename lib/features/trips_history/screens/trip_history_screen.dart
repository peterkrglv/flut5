import 'package:flutter/material.dart';
import 'package:prac5/features/trp/models/trip_model.dart';
import 'package:prac5/shared/eco_data_manager.dart';
import 'package:provider/provider.dart';

class TripHistoryScreen extends StatelessWidget {
  const TripHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EcoDataManager>(
      builder: (context, dataManager, child) {
        final List<TripModel> trips = dataManager.trips;

        return Scaffold(
          appBar: AppBar(
            title: const Text('История поездок'),
          ),
          body: trips.isEmpty
              ? const Center(
            child: Text(
              'Пока нет сохраненных поездок.',
              style: TextStyle(fontSize: 16),
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips.reversed.toList()[index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: ListTile(
                  leading: Icon(trip.transport.iconData, size: 30),
                  title: Text(
                    '${trip.transport.name} (${trip.distanceKm.toStringAsFixed(1)} км)',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Дата: ${trip.date.day}.${trip.date.month}.${trip.date.year}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${trip.carbonFootprintKg.toStringAsFixed(3)} кг CO₂',
                        style: const TextStyle(fontSize: 14),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          dataManager.deleteTrip(trip.id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}