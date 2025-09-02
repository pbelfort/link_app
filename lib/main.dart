import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/services/url_shortener_service.dart';
import 'presentation/providers/url_provider.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UrlProvider(UrlShortenerService()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    ),
  );
}
