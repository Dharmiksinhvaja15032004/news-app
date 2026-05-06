import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';
import '../datasource/news_local_data_source.dart';

class NewsRemoteDataSource {
  final String nyApiKey = "30OAO2e3aDZkVCvzxy9sVNEgbIchchzEaG6erNvBgDQAprji";
  final NewsLocalDataSource localDataSource;
  NewsRemoteDataSource(this.localDataSource);
  Future<List<ArticleModel>> getNews({
    required String category,
    String? country,
  }) async {
    try {
      final url = "https://api.nytimes.com/svc/topstories/v2/$category.json?api-key=$nyApiKey";
      print("URL: $url");
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'];
        if (results == null || results is! List) {
          return [];
        }
        final articles = results
            .where((e) => e != null)
            .map((e) => ArticleModel.fromJson(e))
            .toList();
        await localDataSource.cacheNews(articles, category);
        return articles;
      }
      if (response.statusCode == 429 ||
          response.body.contains("QuotaViolation")) {
        print("⚠️ Rate limit → loading from cache");
        return localDataSource.getByCategory(category);
      }
      print("ERROR BODY: ${response.body}");
      return localDataSource.getByCategory(category);
    } catch (e) {
      print("EXCEPTION: $e");
      return localDataSource.getByCategory(category);
    }
  }
}