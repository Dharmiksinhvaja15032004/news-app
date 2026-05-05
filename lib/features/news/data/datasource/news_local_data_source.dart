import 'package:hive/hive.dart';
import '../models/article_model.dart';

class NewsLocalDataSource {
  final box = Hive.box('newsBox');

  Future<void> cacheNews(List<ArticleModel> articles) async {
    final data = articles.map((e) => {
      "title": e.title,
      "author": e.author,
      "description": e.description,
      "image": e.image,
      "date": e.date,
      "url": e.url,
    }).toList();

    await box.put('cached_news', data);
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
}