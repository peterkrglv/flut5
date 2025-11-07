import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prac5/features/transport/screens/transport_screen.dart';
import 'package:prac5/features/trips_history/screens/trip_history_screen.dart';
import 'package:prac5/features/trp/screens/trip_screen.dart';
import 'package:prac5/features/user_profile/screens/user_profile_screen.dart';
import 'package:prac5/shared/eco_data_manager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF1B5E20);
    return ChangeNotifierProvider(
      create: (context) => EcoDataManager(),
      child: MaterialApp(
        title: 'CarbonTrack App',
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: primaryGreen)
        ),
        home: const HomeScreen(),
      ),
    );
  }
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _url = 'https://example.com/welcome_image.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CarbonTrack',
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Добро пожаловать!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Ваш инструмент для учета углеродного следа.',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            CachedNetworkImage(
                imageUrl: _url,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                const Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                    )
                )
            ),

            const SizedBox(height: 40),

            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildNavigationButton(
                      context,
                      'Добавить новую поездку',
                      const Icon(Icons.add_location_alt),
                      const TripAddScreen(),
                    ),

                    _buildNavigationButton(
                      context,
                      'История поездок',
                      const Icon(Icons.history),
                      const TripHistoryScreen(),
                    ),

                    _buildNavigationButton(
                      context,
                      'Эко-Профиль',
                      const Icon(Icons.person),
                      const UserProfileScreen(),
                    ),

                    _buildNavigationButton(
                      context,
                      'Сравнение транспорта',
                      const Icon(Icons.compare_arrows),
                      const TransportScreen(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context,
      String title,
      Icon icon,
      Widget destinationScreen,) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        icon: icon,
        label: Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => destinationScreen,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
      ),
    );
  }
}
