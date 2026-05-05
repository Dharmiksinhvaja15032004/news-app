class Article {
  final String title;
  final String author;
  final String description;
  final String image;
  final String date;
  final String url;

  Article({
    required this.title,
    required this.author,
    required this.description,
    required this.image,
    required this.date,
    required this.url,
  });
  String get id => url;
}