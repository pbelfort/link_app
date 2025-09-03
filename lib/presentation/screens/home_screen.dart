import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_app/presentation/providers/alias_state.dart';
import '../providers/alias_provider.dart';
import '../widgets/link_tile.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late AliasProvider _provider;
  late AliasState _state;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _state = ref.watch(urlProvider);
    _provider = ref.read(urlProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('URL Shortener'),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Digite a URL',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_state.loading) return;
                    final url = _controller.text;
                    if (url.isNotEmpty) {
                      _provider.createAlias(url: url, context: context);
                      _controller.clear();
                    }
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Recently shortened URLs'),
            ),
            const SizedBox(height: 20),
            if (_state.loading) const LinearProgressIndicator(),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: _state.history.length,
                      (context, index) {
                        final link = _state.history[index];
                        return LinkTile(link: link);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
