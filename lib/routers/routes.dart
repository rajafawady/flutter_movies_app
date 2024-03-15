import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/screens/favorites_screen.dart';

import 'package:movies_app/screens/genre.dart';
import 'package:movies_app/screens/home.dart';
import 'package:movies_app/screens/widgets/main_wrapper.dart';

class AppNavigation {
  AppNavigation._();
  static final _routeNavigatorKey = GlobalKey<NavigatorState>();
  static final _routeNavigatorHome =
      GlobalKey<NavigatorState>(debugLabel: 'ShellHome');
  static final _routeNavigatorSearch =
      GlobalKey<NavigatorState>(debugLabel: 'ShellSearch');
  static final _routeNavigatorFavorites =
      GlobalKey<NavigatorState>(debugLabel: 'ShellFavorites');

  static final GoRouter router = GoRouter(
    errorPageBuilder: (context, state) => MaterialPage(
      child: Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Text('Error: ${state.error?.message}'),
        ),
      ),
    ),
    initialLocation: '/',
    navigatorKey: _routeNavigatorKey,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return MainWrapper(
              navigationShell: navigationShell,
            );
          },
          branches: <StatefulShellBranch>[
            //Home Branch
            StatefulShellBranch(navigatorKey: _routeNavigatorHome, routes: [
              GoRoute(
                path: '/',
                name: 'Home',
                builder: (BuildContext context, GoRouterState state) {
                  return Home(key: state.pageKey);
                },
              ),
            ]),

            // Search Branch
            StatefulShellBranch(navigatorKey: _routeNavigatorSearch, routes: [
              GoRoute(
                path: '/search',
                name: 'Search',
                builder: (BuildContext context, GoRouterState state) {
                  return Genre(key: state.pageKey);
                },
              )
            ]),

            // Favorites Branch
            StatefulShellBranch(
                navigatorKey: _routeNavigatorFavorites,
                routes: [
                  GoRoute(
                    path: '/favorites',
                    name: 'Favorites',
                    builder: (BuildContext context, GoRouterState state) {
                      return FavoriteScreen(key: state.pageKey);
                    },
                  )
                ]),
          ]),
    ],
  );
}
