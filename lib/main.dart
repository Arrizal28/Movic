import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movic/presentation/pages/about_page.dart';
import 'package:movic/presentation/pages/home_movie_page.dart';
import 'package:movic/presentation/pages/movie_detail_page.dart';
import 'package:movic/presentation/pages/popular_movies_page.dart';
import 'package:movic/presentation/pages/search_page.dart';
import 'package:movic/presentation/pages/top_rated_movies_page.dart';
import 'package:movic/presentation/pages/watchlist_movies_page.dart';
import 'package:movic/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:movic/presentation/provider/movie/movie_list_notifier.dart';
import 'package:movic/presentation/provider/movie/movie_search_notifier.dart';
import 'package:movic/presentation/provider/movie/popular_movies_notifier.dart';
import 'package:movic/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:movic/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:movic/presentation/provider/tv/now_playing_tv_series_notifier.dart';
import 'package:movic/presentation/provider/tv/popular_tv_series_notifier.dart';
import 'package:movic/presentation/provider/tv/top_rated_tv_series_notifier.dart';
import 'package:movic/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:movic/presentation/provider/tv/tv_search_notifier.dart';
import 'package:movic/presentation/provider/tv/tv_series_list_notifier.dart';
import 'package:movic/presentation/provider/tv/watchlist_tv_notifier.dart';
import 'package:movic/presentation/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:movic/injection.dart' as di;

import 'common/constants.dart';
import 'common/utils.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.locator<MovieListNotifier>()),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<NowPlayingTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesListNotifier>(),
        ),
        ChangeNotifierProvider(create: (_) => di.locator<TvDetailNotifier>()),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvNotifier>(),
        ),
        ChangeNotifierProvider(create: (_) => di.locator<TvSearchNotifier>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          drawerTheme: kDrawerTheme,
        ),
        home: Material(child: CustomDrawer(content: HomeMoviePage())),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            // case TvDetailPage.ROUTE_NAME:
            //   final args = settings.arguments as Map<String, dynamic>;
            //   final id = args['id'] as int;
            //   return MaterialPageRoute(
            //     builder: (_) => TvDetailPage(id: id),
            //   );
            // case TvSeriesListPage.ROUTE_NAME:
            //   return CupertinoPageRoute(
            //       builder: (_) => const TvSeriesListPage()
            //   );
            // case PopularTvPage.ROUTE_NAME:
            //   return CupertinoPageRoute(
            //       builder: (_) => const PopularTvPage()
            //   );
            // case TopRatedTvPage.ROUTE_NAME:
            //   return CupertinoPageRoute(
            //       builder: (_) => const TopRatedTvPage()
            //   );
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return Scaffold(
                    body: Center(child: Text('Page not found :(')),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
