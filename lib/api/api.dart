import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app/data/movie_data_model.dart';

Future<void> saveToHive(List<dynamic> movies, String boxName) async {
  final movieBox = Hive.box(boxName);
  await movieBox.clear(); // Clear existing data
  movieBox.addAll(movies);
}

Future discover() async {
  await dotenv.load();
  final String url =
      '${dotenv.env["API_URL"]}/discover/movie?api_key=${dotenv.env["API_KEY"]}';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var responseData = json.decode(response.body);
    var temp = responseData['results'];
    List<dynamic> movies = temp.map((movie) {
      return MovieDataModel(
          id: movie['id'] as int,
          title: movie['title']!,
          description: movie['overview']!,
          releaseDate: movie['release_date']!,
          posterUrl:
              dotenv.env['IMAGES_URL']! + '/w500' + movie['poster_path']!);
    }).toList();

    await saveToHive(movies, 'trendingMovies');
  } else {
    throw Exception('Failed to load movies');
  }
}

Future fetchMoviesByGenre(String id) async {
  await dotenv.load();
  final String url =
      '${dotenv.env["API_URL"]}/discover/movie?with_genres=${id}api_key=${dotenv.env["API_KEY"]}';
  final response = await http.get(Uri.parse(url));
  var responseData = json.decode(response.body);
  return responseData['results'];
}

Future fetchTrailer(int id) async {
  await dotenv.load();
  final String url =
      '${dotenv.env["API_URL"]}/movie/$id/videos?api_key=${dotenv.env["API_KEY"]}';
  final response = await http.get(Uri.parse(url));
  var responseData = json.decode(response.body)['results'];
  var officialTrailer = responseData.where((item) {
    return item['name'] == 'Official Trailer';
  }).toList();
  String ytKey = officialTrailer[0]['key'];
  return ytKey;
}
