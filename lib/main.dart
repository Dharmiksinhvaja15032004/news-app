import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'features/news/data/datasource/news_local_data_source.dart';
import 'features/news/data/datasource/news_remote_data_source.dart';
import 'features/news/data/repository/news_repository_impl.dart';
import 'features/news/domain/usecases/get_news.dart';
import 'features/news/presentation/provider/news_provider.dart';
import 'features/news/presentation/provider/theme_provider.dart';
import 'features/news/presentation/screens/home_screen.dart';
import 'features/news/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('newsBox');
  final localDataSource = NewsLocalDataSource();
  final remoteDataSource = NewsRemoteDataSource(localDataSource);
  final repository =
  NewsRepositoryImpl(remoteDataSource, localDataSource);
  final getNews = GetNews(repository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider(getNews,localDataSource)),
        ChangeNotifierProvider(create: (_) => ThemeProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      themeMode: Provider.of<ThemeProvider>(context).themeMode,

      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.deepPurple,

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),

        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
          titleMedium: TextStyle(color: Colors.black),
        ),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),

        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
        ),
      ),

      home: const SplashScreen(),
    );
  }
}