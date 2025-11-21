import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../trp/models/trip_model.dart';
import '../сubit/trip_history_cubit.dart';

class TripHistoryScreen extends StatelessWidget {
  const TripHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String placeholderImageUrl = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Bew_75km.JPG/1280px-Bew_75km.jpg";

    final TripHistoryCubit cubit = context.read<TripHistoryCubit>();

    return BlocBuilder<TripHistoryCubit, TripHistoryState>(
      builder: (context, state) {
        final List<TripModel> trips = state.trips;

        return Scaffold(
          appBar: AppBar(
            title: const Text('История поездок'),
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                context.pop();
              },
            ),
          ),
          body: trips.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: placeholderImageUrl,
                  width: 600,
                  height: 600,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red, size: 100),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Пока нет сохраненных поездок.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index];

              return TripRow(
                trip: trip,
                key: ValueKey(trip.id),
                onRemove: () {
                  cubit.deleteTrip(trip.id);
                },
              );
            },
          ),
        );
      },
    );
  }
}


class TripRow extends StatelessWidget {
  final TripModel trip;
  final VoidCallback? onRemove;

  const TripRow({
    required this.trip,
    this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}