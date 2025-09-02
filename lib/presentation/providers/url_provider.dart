import 'package:flutter/material.dart';
import '../../data/models/shortened_link.dart';
import '../../data/services/url_shortener_service.dart';

class UrlProvider extends ChangeNotifier {
  final UrlShortenerService service;
  UrlProvider(this.service);

  final List<ShortenedLink> _history = [];
  bool _loading = false;

  List<ShortenedLink> get history => List.unmodifiable(_history);
  bool get loading => _loading;

  Future<void> shorten(String url) async {
    _loading = true;
    notifyListeners();

    try {
      final link = await service.shortenUrl(url);
      _history.insert(0, link);
    } catch (e) {
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
