import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_app/presentation/providers/alias_state.dart';
import '../providers/alias_provider.dart';
import '../widgets/link_tile.dart';

const kCustomScrollViewKey = ValueKey('mainScrollView');

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late AliasProvider _provider;
  late AliasState _state;
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
            Form(
              key: _formKey,
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'http://example.com',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => _provider.validateUrl(value),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_state.loading) return;
                      if (_formKey.currentState!.validate()) {
                        final url = _controller.text;
                        _provider.createAlias(url: url);
                        _controller.clear();
                        FocusScope.of(context).unfocus();
                      }
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
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
                key: kCustomScrollViewKey,
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: _state.history.length,
                      (context, index) {
                        final link = _state.history[index];
                        return LinkTile(link: link, key: Key(link.original));
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
