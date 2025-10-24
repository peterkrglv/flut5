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
  final TextEditingController _distanceController = TextEditingController();
  TransportModel? _selectedTransport;
  double _calculatedFootprint = 0.0;

  void _calculateFootprint() {
    final double distance = double.tryParse(_distanceController.text) ?? 0.0;
    if (_selectedTransport != null && distance > 0) {
      setState(() {
        _calculatedFootprint = distance * _selectedTransport!.co2PerKm;
      });
    } else {
      setState(() {
        _calculatedFootprint = 0.0;
      });
    }
  }

  void _saveTrip() {
    if (_calculatedFootprint > 0) {
      Provider.of<EcoDataManager>(context, listen: false).addTrip(
        distanceKm: double.parse(_distanceController.text),
        transport: _selectedTransport!,
        carbonFootprintKg: _calculatedFootprint,
      );

      _distanceController.clear();
      setState(() {
        _selectedTransport = null;
        _calculatedFootprint = 0.0;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Поездка сохранена!')),
      );
    }
  }

  void _onFormChange() {
    _calculateFootprint();
  }

  @override
  void initState() {
    super.initState();
    _distanceController.addListener(_onFormChange);
  }

  @override
  void dispose() {
    _distanceController.removeListener(_onFormChange);
    _distanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transports = Provider.of<EcoDataManager>(context).availableTransports;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить поездку'),
      ),
      body: SingleChildScrollView(
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
              value: _selectedTransport,
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
                setState(() {
                  _selectedTransport = newValue;
                  _calculateFootprint();
                });
              },
            ),

            const SizedBox(height: 30),

            FootprintResultCard(footprintKg: _calculatedFootprint),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: _calculatedFootprint > 0 ? _saveTrip : null,
              child: const Text('Сохранить поездку', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
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
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Расчетный углеродный след:',
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
    );
  }
}

