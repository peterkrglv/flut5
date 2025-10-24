import 'package:flutter/material.dart';
import 'package:prac5/features/transport/models/transport_model.dart';
import 'package:prac5/shared/eco_data_manager.dart';
import 'package:provider/provider.dart';

class TripAddScreen extends StatefulWidget {
  const TripAddScreen({super.key});

  @override
  State<TripAddScreen> createState() => _TripAddScreenState();
}

class _TripAddScreenState extends State<TripAddScreen> {
  final _distanceController = TextEditingController();
  TransportModel? _selectedTransport;
  double _calculatedFootprint = 0.0;

  @override
  void dispose() {
    _distanceController.dispose();
    super.dispose();
  }

  void _calculateFootprint() {
    final distance = double.tryParse(_distanceController.text) ?? 0.0;

    if (_selectedTransport != null && distance > 0) {
      setState(() {
        _calculatedFootprint = (distance * _selectedTransport!.co2PerKm) / 1000;
      });
    } else {
      setState(() {
        _calculatedFootprint = 0.0;
      });
    }
  }

  void _saveTrip() {
    if (_calculatedFootprint > 0 && _selectedTransport != null) {
      final dataManager = Provider.of<EcoDataManager>(context, listen: false);

      dataManager.addTrip(
        distanceKm: double.tryParse(_distanceController.text) ?? 0.0,
        transport: _selectedTransport!,
        carbonFootprintKg: _calculatedFootprint,
      );

      final String message =
          'Сохранено: ${_selectedTransport!.name}. След: ${_calculatedFootprint.toStringAsFixed(3)} кг CO₂';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 3),
        ),
      );

      setState(() {
        _distanceController.clear();
        _selectedTransport = null;
        _calculatedFootprint = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataManager = Provider.of<EcoDataManager>(context, listen: false);
    final transports = dataManager.availableTransports;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить поездку'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _distanceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Расстояние (км)',
                hintText: 'Введите пройденное расстояние',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _calculateFootprint(),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<TransportModel>(
              decoration: const InputDecoration(
                labelText: 'Вид транспорта',
                border: OutlineInputBorder(),
              ),
              value: _selectedTransport,
              items: transports.map((TransportModel transport) {
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
                setState(() {
                  _selectedTransport = newValue;
                });
                _calculateFootprint();
              },
            ),

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'Расчетный след CO₂: ${_calculatedFootprint.toStringAsFixed(3)} кг',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: (_calculatedFootprint > 0) ? _saveTrip : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Сохранить поездку',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}