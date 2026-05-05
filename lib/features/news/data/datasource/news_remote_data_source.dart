import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class NewsRemoteDataSource {
  final String apiKey = "30OAO2e3aDZkVCvzxy9sVNEgbIchchzEaG6erNvBgDQAprji";

  Future<List<ArticleModel>> getNews(String category) async {
    final response = await http.get(Uri.parse(
        "https://api.nytimes.com/svc/topstories/v2/$category.json?api-key=$apiKey"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List results = data['results'];
      return results.map((e) => ArticleModel.fromJson(e)).toList();
    } else {
      print("STATUS CODE: ${response.statusCode}");
      print("BODY: ${response.body}");
      throw Exception("API Error");
    }
  }
}