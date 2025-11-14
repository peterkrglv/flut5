import 'package:flutter/material.dart';
import 'package:prac5/features/transport/models/transport_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TransportScreen extends StatelessWidget {
  const TransportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transports = getMockTransports();
    const String imageUrl = "https://upload.wikimedia.org/wikipedia/commons/7/7a/KamAZ-6282_electric_bus_on_line_T25_in_Moscow.jpg";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Транспорт'),
      ),
      body: ListView(
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
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}