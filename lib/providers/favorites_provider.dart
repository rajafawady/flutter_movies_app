import 'package:flutter/material.dart';

class FavoriteMoviesProvider extends ChangeNotifier {
  List<dynamic> _favMovies = [];

  List<dynamic> get favMovies => _favMovies;

  void updateFavMovies(List<dynamic> updatedMovies) {
    _favMovies = updatedMovies;
    notifyListeners();
  }
}
