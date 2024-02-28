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
