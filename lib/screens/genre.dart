import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:movies_app/data/genre_data_model.dart';
import 'package:movies_app/screens/movies_list.dart';
import 'package:movies_app/screens/widgets/genre_tile.dart';

class Genre extends StatefulWidget {
  Genre({super.key});

  @override
  State<Genre> createState() => _GenreState();
}

class _GenreState extends State<Genre> {
  bool isSearching = false;
  late Box movieBox;
  List<dynamic> filteredMovies = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    movieBox = Hive.box('trendingMovies');
    filteredMovies = movieBox.values.toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void search(String query) {
    setState(() {
      isSearching = true;
      filteredMovies = movieBox.values
          .where((movie) =>
              movie.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white
                    .withOpacity(0.5), // Semi-transparent white background
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search movies...',
                  border: InputBorder.none, // Remove the default border
                  hintStyle: TextStyle(color: Colors.white70),
                  icon: Icon(Icons.search, color: Colors.white),
                ),
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                cursorColor:
                    Theme.of(context).colorScheme.primary, // Cursor color
                autofocus: false,
                onChanged: search,
              ),
            ),
            if (isSearching) // Show the clear button only when searching
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                      _searchController.clear();
                      FocusScope.of(context).unfocus();
                    });
                  },
                ),
              ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: (!isSearching)
          ? GridView.count(
              crossAxisCount: 2,
              children: genreList.map((genre) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return MoviesList(movies: []);
                    }));
                  },
                  child: GenreTile(genre: genre),
                );
              }).toList(),
            )
          : MoviesList(movies: filteredMovies),
    );
  }
}
