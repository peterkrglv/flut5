import 'package:flutter/material.dart';
import 'package:prac5/features/transport/models/transport_model.dart';

class TransportScreen extends StatelessWidget {
  const TransportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transports = getMockTransports();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Траспорт'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: transports.length,
        itemBuilder: (context, index) {
          final transport = transports[index];
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
            ),
          );
        },
      ),
    );
  }
}