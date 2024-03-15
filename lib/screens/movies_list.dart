import 'package:flutter/material.dart';

import 'package:movies_app/screens/movie_details_screen.dart';
import 'package:movies_app/screens/widgets/movie_tile.dart';

class MoviesList extends StatelessWidget {
  final List<dynamic> movies;

  const MoviesList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return MovieDetailsScreen(movie: movies[index]);
                  }));
                },
                child: MovieTile(movie: movies[index]));
          }),
    );
  }
}
