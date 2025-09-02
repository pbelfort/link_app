class ShortenedLink {
  final String alias;
  final String original;
  final String short;

  ShortenedLink({
    required this.alias,
    required this.original,
    required this.short,
  });

  factory ShortenedLink.fromJson(Map<String, dynamic> json) {
    return ShortenedLink(
      alias: json['alias'],
      original: json['_links']['self'],
      short: json['_links']['short'],
    );
  }
}
