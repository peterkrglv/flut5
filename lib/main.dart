import 'package:flutter/material.dart';
import 'package:prac5/shared/app_router.dart';
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