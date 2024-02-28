import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/api/api.dart';
import 'package:movies_app/data/movie_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    print('initial');
    emit(HomeLoadingState());
    print('loading emitted');
    List<dynamic> result = await discover();
    print("ok");
    emit(HomeLoadedState(
        movies: result.map((movie) {
      return MovieDataModel(
          id: movie['id'] as int,
          title: movie['title']!,
          description: movie['overview']!,
          releaseDate: movie['release_date']!,
          posterUrl: movie['poster_path']!);
    }).toList()));
  }
}
