import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_app/core/di/locator.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  setupLocator();
  runApp(
    const ProviderScope(
      child: MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen()),
    ),
  );
}
