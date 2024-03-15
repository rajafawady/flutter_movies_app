import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movies_app/screens/movies_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final movieBox = Hive.box('trendingMovies');
    final movies = movieBox.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      body: MoviesList(movies: movies),
    );
  }
}
