// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_anime.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteAnimeAdapter extends TypeAdapter<FavoriteAnime> {
  @override
  final int typeId = 0;

  @override
  FavoriteAnime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteAnime(
      id: fields[0] as int,
      titles: fields[1] as String,
      posterImage: fields[2] as String?,
      ageRating: fields[3] as String?,
      averageRating: fields[4] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteAnime obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.titles)
      ..writeByte(2)
      ..write(obj.posterImage)
      ..writeByte(3)
      ..write(obj.ageRating)
      ..writeByte(4)
      ..write(obj.averageRating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteAnimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
