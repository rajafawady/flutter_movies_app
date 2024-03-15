import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/api/api.dart';
import 'package:movies_app/data/movie_data_model.dart';
import 'package:movies_app/providers/favorites_provider.dart';
import 'package:movies_app/routers/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(MovieDataModelAdapter());
  await Hive.initFlutter();

  await Hive.openBox('trendingMovies');
  await Hive.openBox('favoriteMovies');

  final movieBox = Hive.box('trendingMovies');

  if (movieBox.isEmpty) {
    await discover();
  }

  runApp(
    ChangeNotifierProvider(
      create: (_) => FavoriteMoviesProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: AppNavigation.router,
    );
  }
}
