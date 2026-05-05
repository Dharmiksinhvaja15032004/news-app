import 'package:flutter/material.dart';
import '../../domain/usecases/get_news.dart';
import '../../domain/entities/article.dart';

class NewsProvider extends ChangeNotifier {
  final GetNews getNews;

  NewsProvider(this.getNews);

  List<Article> articles = [];
  List<Article> allArticles = [];
  List<Article> get likedNews {
    return allArticles
        .where((article) => likedArticles.contains(article.id))
        .toList();
  }

  bool isLoading = false;
  String category = "home";

  // ❤️ LIKE SYSTEM
  final Set<String> likedArticles = {};

  bool isLiked(String id) {
    return likedArticles.contains(id);
  }

  void toggleLike(String id) {
    if (likedArticles.contains(id)) {
      likedArticles.remove(id);
    } else {
      likedArticles.add(id);
    }
    notifyListeners();
  }

  // 🔥 SET ARTICLES
  void setArticles(List<Article> newArticles) {
    allArticles = newArticles;
    articles = newArticles;
    notifyListeners();
  }

  // 🔍 SEARCH
  void search(String query) {
    if (query.isEmpty) {
      articles = allArticles;
    } else {
      articles = allArticles.where((article) {
        return article.title.toLowerCase().contains(query.toLowerCase()) ||
            article.description.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  // 🌐 FETCH NEWS
  Future<void> fetchNews(String cat) async {
    category = cat;
    isLoading = true;
    notifyListeners();

    try {
      final data = await getNews(cat);
      setArticles(data);
    } catch (e) {
      print("ERROR: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}