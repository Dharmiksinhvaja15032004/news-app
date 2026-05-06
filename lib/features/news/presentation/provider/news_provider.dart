import 'package:flutter/material.dart';
import '../../domain/usecases/get_news.dart';
import '../../domain/entities/article.dart';
import '../../data/datasource/news_local_data_source.dart';
import '../../data/models/article_model.dart';

class NewsProvider extends ChangeNotifier {
  final GetNews getNews;
  final NewsLocalDataSource local;
  NewsProvider(this.getNews, this.local);
  List<Article> articles = [];
  List<Article> allArticles = [];
  bool isLoading = false;
  bool hasFetched = false;
  String category = "home";
  String country = "INDIA";
  final Set<String> likedArticles = {};
  List<Article> get likedNews {
    return allArticles
        .where((article) => likedArticles.contains(article.id))
        .toList();
  }
  bool isLiked(String id) => likedArticles.contains(id);
  void toggleLike(String id) {
    if (likedArticles.contains(id)) {
      likedArticles.remove(id);
    } else {
      likedArticles.add(id);
    }
    notifyListeners();
  }
  void setArticles(List<Article> newArticles) {
    allArticles = newArticles;
    articles = newArticles;
  }
  void search(String query) {
    if (query.isEmpty) {
      articles = local.getByCategory(category);
    } else {
      articles = local.searchNews(query);
    }
    notifyListeners();
  }
  Future<void> loadInitial() async {
    if (hasFetched) return;
    isLoading = true;
    notifyListeners();
    try {
      final categories = ["home", "world", "science", "sports", "arts"];
      for (var cat in categories) {
        final data = await getNews(cat, country);
        final models = data.map((e) => ArticleModel.fromEntity(e)).toList();
        if (models.isNotEmpty) {
          await local.cacheNews(models, cat);
        }
      }
      final cached = local.getByCategory("home");
      setArticles(cached);
      hasFetched = true;
    } catch (e) {
      final cached = local.getCachedNews();
      setArticles(cached);
    }
    isLoading = false;
    notifyListeners();
  }
  Future<void> filterByCategory(String cat) async {
    category = cat;
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 300));
    final list = local.getByCategory(cat);
    setArticles(list);
    isLoading = false;
    notifyListeners();
  }
  void changeCountry(String newCountry) {
    country = newCountry;
    hasFetched = false;
    refresh();
  }
  Future<void> refresh() async {
    if (isLoading) return;
    isLoading = true;
    notifyListeners();
    try {
      final data = await getNews(category, country);
      final models = data.map((e) => ArticleModel.fromEntity(e)).toList();
      if (models.isNotEmpty) {
        await local.cacheNews(models, category);
      }
      final updated = local.getByCategory(category);
      setArticles(updated);
    } catch (e) {
      print("ERROR: $e");
      final cached = local.getByCategory(category);
      setArticles(cached);
    }
    isLoading = false;
    notifyListeners();
  }
}