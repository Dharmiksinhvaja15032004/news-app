import '../../domain/entities/article.dart';

class ArticleModel extends Article {
  ArticleModel({
    required super.title,
    required super.author,
    required super.description,
    required super.image,
    required super.date,
    required super.url,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? '',
      author: json['byline'] ?? '',
      description: json['abstract'] ?? '',
      image: json['multimedia'] != null
          ? json['multimedia'][0]['url']
          : '',
      date: json['published_date'] ?? '',
      url: json['url'] ?? '',
    );
  }
}