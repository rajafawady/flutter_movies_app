import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/home/bloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (previous, current) {
        if (current is HomeActionState) {
          return true;
        }
        return false;
      },
      buildWhen: (previous, current) {
        if (current is! HomeActionState) {
          return true;
        } else {
          return false;
        }
      },
      listener: (context, state) {},
      builder: (context, state) {
        log("message");
        print('Received state: ${state.runtimeType}');
        switch (state.runtimeType) {
          case HomeLoadingState:
            print('Received HomeLoadingState');
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedState:
            final successState = state as HomeLoadedState;
            final movies = successState.movies;
            return Scaffold(
              appBar: AppBar(
                title: Text('Dashboard'),
              ),
              body: Container(
                child: ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      return Text(movies[index].title);
                    }),
              ),
            );
          case HomeInitial:
            return const Center(
              child: Text("There was an unexpected Error!"),
            );
          default:
            return Text('default');
        }
      },
    );
  }
}
