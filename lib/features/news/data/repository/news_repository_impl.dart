import '../../domain/entities/article.dart';
import '../../domain/repository/news_repository.dart';
import '../datasource/news_local_data_source.dart';
import '../datasource/news_remote_data_source.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;

  NewsRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<List<Article>> getNews(String category, {String? country}) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    // ✅ INTERNET AVAILABLE → API
    if (connectivityResult != ConnectivityResult.none) {
      final remoteNews = await remoteDataSource.getNews(
        category: category,
        country: country, // 🔥 ADD THIS
      );

      // 🔥 SAVE TO HIVE
      await localDataSource.cacheNews(remoteNews, category);

      return remoteNews;
    }

    // ❌ NO INTERNET → LOCAL
    return localDataSource.getCachedNews();
  }
}