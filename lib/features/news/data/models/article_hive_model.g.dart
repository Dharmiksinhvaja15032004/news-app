// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArticleHiveAdapter extends TypeAdapter<ArticleHive> {
  @override
  final int typeId = 0;

  @override
  ArticleHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArticleHive(
      title: fields[0] as String,
      author: fields[1] as String,
      description: fields[2] as String,
      image: fields[3] as String,
      date: fields[4] as String,
      url: fields[5] as String,
      category: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ArticleHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.url)
      ..writeByte(6)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticleHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
