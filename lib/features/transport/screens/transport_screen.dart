import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../models/transport_model.dart';
import '../сubit/transport_cubit.dart';

class TransportScreen extends StatelessWidget {
  const TransportScreen({
    super.key,
  });

  void _addMockTransport(BuildContext context) {
    context.read<TransportCubit>().addTransport(
      'Мой самокат',
      Icons.electric_scooter,
      5.0,
    );
  }

  void _removeTransport(BuildContext context, int id) {
    context.read<TransportCubit>().removeTransport(id);
  }

  @override
  Widget build(BuildContext context) {
    const String imageUrl = "https://upload.wikimedia.org/wikipedia/commons/7/7a/KamAZ-6282_electric_bus_on_line_T25_in_Moscow.jpg";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Транспорт'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            context.pop();
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _addMockTransport(context),
        child: const Icon(Icons.add),
      ),

      body: BlocBuilder<TransportCubit, TransportState>(
        builder: (context, state) {
          final transports = state.transports;

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              SizedBox(
                width: 600,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              ...transports.map((transport) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  child: ListTile(
                    leading: Icon(
                      transport.iconData,
                      size: 30,
                    ),
                    title: Text(
                      transport.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Коэффициент CO₂: ${transport.co2PerKm.toStringAsFixed(1)} г/км',
                      style: const TextStyle(fontSize: 14),
                    ),
                    trailing: transport.isUserAdded
                        ? IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeTransport(context, transport.id),
                    )
                        : const Icon(Icons.lock, size: 20, color: Colors.grey),
                  ),
                );
              }).toList(),

              if (transports.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: Text('Нет доступного транспорта. Добавьте новый!'),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}