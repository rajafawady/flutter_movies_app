import 'package:flutter/material.dart';
import 'package:movies_app/providers/favorites_provider.dart';
import 'package:movies_app/screens/movies_list.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final favoriteMoviesProvider = Provider.of<FavoriteMoviesProvider>(context);

    return favoriteMoviesProvider.favMovies.isNotEmpty
        ? provideScaffold(MoviesList(movies: favoriteMoviesProvider.favMovies))
        : provideScaffold(const Center(
            child: Text('Whoops...Nothing Here :('),
          ));
  }

  Widget provideScaffold(Widget wid) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      body: wid,
    );
  }
}
