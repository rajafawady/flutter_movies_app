import 'package:hive/hive.dart';

class MovieDataModel {
  final int id;
  final String title;
  final String description;

  final String releaseDate;
  final String posterUrl;

  MovieDataModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.releaseDate,
      required this.posterUrl});
}

class MovieDataModelAdapter extends TypeAdapter<MovieDataModel> {
  @override
  final typeId = 1; // You can choose any unique positive integer here

  @override
  MovieDataModel read(BinaryReader reader) {
    return MovieDataModel(
      id: reader.readInt(),
      title: reader.readString(),
      description: reader.readString(),
      releaseDate: reader.readString(),
      posterUrl: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, MovieDataModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.description);
    writer.writeString(obj.releaseDate);
    writer.writeString(obj.posterUrl);
  }
}
