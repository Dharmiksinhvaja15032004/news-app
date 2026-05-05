import '../entities/article.dart';
import '../repository/news_repository.dart';

class GetNews {
  final NewsRepository repository;

  GetNews(this.repository);

  Future<List<Article>> call(String category) {
    return repository.getNews(category);
  }
}