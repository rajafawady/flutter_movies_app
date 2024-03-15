import 'package:flutter/material.dart';
import 'package:movies_app/data/movie_data_model.dart';

class MovieTile extends StatelessWidget {
  final MovieDataModel movie;

  const MovieTile({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.maxFinite,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(movie.posterUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        movie.title,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          backgroundColor: Colors.black.withOpacity(0.2),
        ),
      ),
    );
  }
}
