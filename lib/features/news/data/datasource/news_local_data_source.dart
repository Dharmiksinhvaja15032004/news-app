import 'package:hive/hive.dart';
import '../models/article_model.dart';

class NewsLocalDataSource {
  final box = Hive.box('newsBox');

  /// 🔥 SAVE DATA (WITH CATEGORY)
  Future<void> cacheNews(List<ArticleModel> articles, String category) async {
    final newData = articles.map((e) => {
      "title": e.title,
      "author": e.author,
      "description": e.description,
      "image": e.image,
      "date": e.date,
      "url": e.url,
      "category": category,
    }).toList();

    // 🔥 OLD DATA LOAD
    final existing = box.get('cached_news', defaultValue: []);

    // 🔥 MERGE OLD + NEW
    final merged = [...existing, ...newData];

    // 🔥 REMOVE DUPLICATE (by URL)
    final uniqueMap = {
      for (var item in merged) item['url']: item
    };

    final uniqueList = uniqueMap.values.toList();

    // 🔥 SAVE FINAL DATA
    await box.put('cached_news', uniqueList);
  }

  /// 📖 GET ALL NEWS
  List<ArticleModel> getCachedNews() {
    final data = box.get('cached_news', defaultValue: []);

    return (data as List).map((e) {
      return ArticleModel(
        title: e['title'] ?? '',
        author: e['author'] ?? '',
        description: e['description'] ?? '',
        image: e['image'] ?? '',
        date: e['date'] ?? '',
        url: e['url'] ?? '',
      );
    }).toList();
  }

  /// 🎯 FILTER BY CATEGORY (NO API)
  List<ArticleModel> getByCategory(String category) {
    final data = box.get('cached_news', defaultValue: []);

    return (data as List)
        .where((e) => e['category'] == category)
        .map((e) => ArticleModel(
      title: e['title'] ?? '',
      author: e['author'] ?? '',
      description: e['description'] ?? '',
      image: e['image'] ?? '',
      date: e['date'] ?? '',
      url: e['url'] ?? '',
    ))
        .toList();
  }

  /// 🔍 SEARCH (NO API)
  List<ArticleModel> searchNews(String query) {
    final data = box.get('cached_news', defaultValue: []);

    return (data as List)
        .where((e) =>
    (e['title'] ?? '')
        .toLowerCase()
        .contains(query.toLowerCase()) ||
        (e['description'] ?? '')
            .toLowerCase()
            .contains(query.toLowerCase()))
        .map((e) => ArticleModel(
      title: e['title'] ?? '',
      author: e['author'] ?? '',
      description: e['description'] ?? '',
      image: e['image'] ?? '',
      date: e['date'] ?? '',
      url: e['url'] ?? '',
    ))
        .toList();
  }

  /// ❌ CLEAR CACHE (OPTIONAL)
  Future<void> clearCache() async {
    await box.delete('cached_news');
  }
}