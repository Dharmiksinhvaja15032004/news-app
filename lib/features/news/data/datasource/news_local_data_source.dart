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
    final existing = box.get('cached_news', defaultValue: []);
    final merged = [...existing, ...newData];
    final uniqueMap = {
      for (var item in merged) item['url']: item
    };

    final uniqueList = uniqueMap.values.toList();
    await box.put('cached_news', uniqueList);
  }
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
  Future<void> clearCache() async {
    await box.delete('cached_news');
  }
}