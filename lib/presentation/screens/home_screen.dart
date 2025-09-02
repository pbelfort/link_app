import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_app/presentation/providers/url_state.dart';
import '../providers/url_provider.dart';
import '../widgets/link_tile.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late UrlProvider _provider;
  late UrlState _state;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _state = ref.watch(urlProvider);
    _provider = ref.read(urlProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('URL Shortener')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Digite a URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _provider.loading
                  ? null
                  : () async {
                      if (_controller.text.isNotEmpty) {
                        try {
                          await _provider.shorten(_controller.text);
                          _controller.clear();
                        } catch (_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Erro ao encurtar URL'),
                            ),
                          );
                        }
                      }
                    },
              child: _provider.loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Encurtar'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _state.history.length,
                itemBuilder: (context, index) {
                  return LinkTile(link: _state.history[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
