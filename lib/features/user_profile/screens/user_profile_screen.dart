import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/eco_data_manager.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EcoDataManager>(
      builder: (context, dataManager, child) {
        final userProfile = dataManager.userProfile;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Ваш Эко-Профиль'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Общая статистика',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.alt_route),
                    title: const Text('Количество поездок'),
                    trailing: Text(
                      '${userProfile.totalTrips}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.cloud_queue),
                    title: const Text('Суммарный углеродный след'),
                    trailing: Text(
                      '${userProfile.totalCarbonKg.toStringAsFixed(3)} кг CO₂',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.favorite_border),
                    title: const Text('Ваш любимый транспорт'),
                    trailing: Text(
                      userProfile.mostUsedTransport,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}