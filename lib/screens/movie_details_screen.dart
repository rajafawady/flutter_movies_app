import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movies_app/data/movie_data_model.dart';
import 'package:movies_app/providers/favorites_provider.dart';
import 'package:movies_app/screens/youtube_player.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatefulWidget {
  final MovieDataModel movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    checkFav();
  }

  bool checkFav() {
    var favoriteBox = Hive.box('favoriteMovies');
    if (favoriteBox.isOpen) {
      var existingIndex = favoriteBox.values.toList().indexOf(widget.movie);
      if (existingIndex != -1) {
        isFav = true; // Indicate that movie was removed
      }
    }
    return false;
  }

  void addOrRemoveMovieToFav(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    var favoriteMoviesProvider =
        Provider.of<FavoriteMoviesProvider>(context, listen: false);
    var favoriteBox = Hive.box('favoriteMovies');
    if (favoriteBox.isOpen) {
      var existingIndex = favoriteBox.values.toList().indexOf(widget.movie);
      if (existingIndex != -1) {
        // Movie exists, remove it
        favoriteBox.deleteAt(existingIndex);
        setState(() {
          isFav = false;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Movie removed from favorites!')));
        });
      } else {
        // Movie does not exist, add it
        favoriteBox.add(widget.movie);
        setState(() {
          isFav = true;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Movie Added to favorites!')));
        });
      }
      favoriteMoviesProvider.updateFavMovies(favoriteBox.values.toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.movie.title),
            IconButton(
                onPressed: () {
                  addOrRemoveMovieToFav(context);
                },
                icon: Icon(!isFav ? Icons.favorite_border : Icons.favorite)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Hero(
                  tag: widget.movie.id,
                  child: Image.network(
                    widget.movie.posterUrl,
                    width: double.infinity,
                    height: 500,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20, // Adjust bottom padding as needed
                  child: Column(
                    children: [
                      Text(
                        'Release Date: ${widget.movie.releaseDate}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                            backgroundColor: Colors.black.withOpacity(0.3)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle button 1 tap
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        child: const Text('Get Tickets'),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black.withOpacity(0.5),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return YoutubePlayerScreen(movie: widget.movie);
                          }));
                        },
                        child: const Text("Watch Trailer"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              "Overview",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                widget.movie.description,
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }
}
