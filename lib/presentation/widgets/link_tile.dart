import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:link_app/domain/entities/shortened_link_entity.dart';

class LinkTile extends StatelessWidget {
  final ShortenedLinkEntity link;
  const LinkTile({super.key, required this.link});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(link.short),
        subtitle: Text(link.original),
        trailing: IconButton(
          icon: const Icon(Icons.copy),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: link.short));
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Link copiado!')));
          },
        ),
      ),
    );
  }
}
