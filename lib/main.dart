import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prac5/shared/app_router.dart';
import 'package:prac5/shared/app_state.dart';
import 'package:prac5/shared/eco_data_manager.dart';
import 'package:prac5/shared/service_locator.dart';
import 'package:provider/provider.dart';

import 'features/transport/models/transport_model.dart';

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
      child: MaterialApp.router(
        title: 'CarbonTrack App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: primaryGreen),
        ),
        routerConfig: router,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String appName;

  const HomeScreen({required this.appName, super.key});

  @override
  Widget build(BuildContext context) {
    final appStateService = locator.get<AppStateService>();
    final transport = appStateService.transport;

    final dataManager = Provider.of<EcoDataManager>(context, listen: false);

    final List<TransportModel> availableTransports =
        dataManager.availableTransports;

    const String imageUrl =
        "https://cdn-icons-png.flaticon.com/512/4431/4431647.png";

    return AppState(
      transports: availableTransports,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            appName,
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.go('/login');
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Добро пожаловать!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Ваш инструмент для учета углеродного следа.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Center(child: _buildImage(imageUrl)),
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
                        '/add-trip',
                        extra: 0.0,
                      ),
                      _buildNavigationButton(context, 'История поездок', '/history'),
                      _buildNavigationButton(context, 'Эко-Профиль', '/profile'),
                      _buildNavigationButton(
                        context,
                        'Сравнение транспорта',
                        '/transports-compare',
                        extra: availableTransports,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) => Container(
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
      const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) =>
      const Center(child: Icon(Icons.error, color: Colors.red, size: 100)),
    );
  }

  Widget _buildNavigationButton(
      BuildContext context,
      String title,
      String path, {
        dynamic extra,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          context.push(path, extra: extra);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        child: Text(title, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}