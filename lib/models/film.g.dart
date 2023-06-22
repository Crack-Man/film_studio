// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FilmAdapter extends TypeAdapter<Film> {
  @override
  final int typeId = 1;

  @override
  Film read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Film(
      id: fields[0] as int,
      name: fields[1] as String,
      description: fields[2] as String,
      year: fields[3] as int,
      rating: fields[4] as Rating,
      poster: fields[5] as String,
      logo: fields[6] as String,
      genres: (fields[7] as List).cast<Genre>(),
      movieLength: fields[8] as int,
      ageRating: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Film obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.year)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.poster)
      ..writeByte(6)
      ..write(obj.logo)
      ..writeByte(7)
      ..write(obj.genres)
      ..writeByte(8)
      ..write(obj.movieLength)
      ..writeByte(9)
      ..write(obj.ageRating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilmAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
