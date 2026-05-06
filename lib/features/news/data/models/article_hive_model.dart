import 'package:hive/hive.dart';

part 'article_hive_model.g.dart';

@HiveType(typeId: 0)
class ArticleHive extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String author;

  @HiveField(2)
  String description;

  @HiveField(3)
  String image;

  @HiveField(4)
  String date;

  @HiveField(5)
  String url;

  @HiveField(6)
  String category;

  ArticleHive({
    required this.title,
    required this.author,
    required this.description,
    required this.image,
    required this.date,
    required this.url,
    required this.category,
  });
}