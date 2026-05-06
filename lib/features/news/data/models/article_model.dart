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

  // 📰 NYTIMES API
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? '',
      author: json['byline'] ?? '',
      description: json['abstract'] ?? '',

      // 🔥 SAFE IMAGE FIX
      image: (json['multimedia'] != null &&
          json['multimedia'] is List &&
          json['multimedia'].isNotEmpty)
          ? json['multimedia'][0]['url'] ?? ''
          : '',

      date: json['published_date'] ?? '',
      url: json['url'] ?? '',
    );
  }

  // 🌍 NEWS API (COUNTRY FILTER SUPPORT)
  factory ArticleModel.fromNewsApi(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      description: json['description'] ?? '',
      image: json['urlToImage'] ?? '',
      date: json['publishedAt'] ?? '',
      url: json['url'] ?? '',
    );
  }
  factory ArticleModel.fromEntity(Article article) {
    return ArticleModel(
      title: article.title,
      author: article.author,
      description: article.description,
      image: article.image,
      date: article.date,
      url: article.url,
    );
  }
}