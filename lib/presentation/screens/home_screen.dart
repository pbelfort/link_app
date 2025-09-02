import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/url_provider.dart';
import '../widgets/link_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            Consumer<UrlProvider>(
              builder: (context, provider, child) {
                return ElevatedButton(
                  onPressed: provider.loading
                      ? null
                      : () async {
                          if (_controller.text.isNotEmpty) {
                            try {
                              await provider.shorten(_controller.text);
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
                  child: provider.loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Encurtar'),
                );
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<UrlProvider>(
                builder: (context, provider, child) {
                  return ListView.builder(
                    itemCount: provider.history.length,
                    itemBuilder: (context, index) {
                      return LinkTile(link: provider.history[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
