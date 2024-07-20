class Gif {
  final String id;
  final String url;
  final String title;

  Gif({required this.id, required this.url, required this.title});

  factory Gif.fromJson(Map<String, dynamic> json) {
    return Gif(
      id: json['id'] as String,
      url: json['images']['fixed_height']['url'] as String,
      title: json['title'] as String,
    );
  }
}
