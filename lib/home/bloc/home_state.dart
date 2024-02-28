part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<MovieDataModel> movies;

  HomeLoadedState({required this.movies});
}

class HomeErrorState extends HomeState {}

class HomeNavigateToMovieDetailsActionState extends HomeActionState {}
