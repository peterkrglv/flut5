import 'package:flutter/material.dart';
import '../features/transport/models/transport_model.dart';

class AppState extends InheritedWidget {
  final List<TransportModel> transports;

  const AppState({
    super.key,
    required this.transports,
    required super.child,
  });

  static AppState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AppState>();
    assert(result != null, 'No AppState found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant AppState oldWidget) {
    return transports != oldWidget.transports;
  }
}