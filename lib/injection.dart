import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:movic/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:movic/presentation/provider/movie/movie_list_notifier.dart';
import 'package:movic/presentation/provider/movie/movie_search_notifier.dart';
import 'package:movic/presentation/provider/movie/now_playing_movies_notifier.dart';
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
import 'data/datasources/db/database_helper.dart';
import 'data/datasources/movie_local_data_source.dart';
import 'data/datasources/movie_remote_data_source.dart';
import 'data/datasources/tv_local_data_source.dart';
import 'data/datasources/tv_remote_data_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'data/repositories/tv_repository_impl.dart';
import 'domain/repositories/movie_repository.dart';
import 'domain/repositories/tv_repository.dart';
import 'domain/usecases/movie/get_movie_detail.dart';
import 'domain/usecases/movie/get_movie_recommendations.dart';
import 'domain/usecases/movie/get_now_playing_movies.dart';
import 'domain/usecases/movie/get_popular_movies.dart';
import 'domain/usecases/movie/get_top_rated_movies.dart';
import 'domain/usecases/movie/get_watchlist_movies.dart';
import 'domain/usecases/movie/get_watchlist_status.dart';
import 'domain/usecases/movie/remove_watchlist.dart';
import 'domain/usecases/movie/save_watchlist.dart';
import 'domain/usecases/movie/search_movies.dart';
import 'domain/usecases/tv/get_now_playing_tv_series.dart';
import 'domain/usecases/tv/get_popular_tv_series.dart';
import 'domain/usecases/tv/get_top_rated_tv_series.dart';
import 'domain/usecases/tv/get_tv_detail.dart';
import 'domain/usecases/tv/get_tv_recommendations.dart';
import 'domain/usecases/tv/get_tv_watchlist_status.dart';
import 'domain/usecases/tv/get_watchlist_tv_series.dart';
import 'domain/usecases/tv/remove_tv_watchlist.dart';
import 'domain/usecases/tv/save_tv_watchlist.dart';
import 'domain/usecases/tv/search_tv_series.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(() => MovieSearchNotifier(searchMovies: locator()));
  locator.registerFactory(() => PopularMoviesNotifier(locator()));
  locator.registerFactory(
    () => TopRatedMoviesNotifier(getTopRatedMovies: locator()),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(getWatchlistMovies: locator()),
  );
  locator.registerFactory(
    () => NowPlayingMoviesNotifier(getNowPlayingMovies: locator()),
  );

  locator.registerFactory(
    () => TvSeriesListNotifier(
      getNowPlayingTvSeries: locator(),
      getPopularTvSeries: locator(),
      getTopRatedTvSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => TvDetailNotifier(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getTvWatchlistStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );

  locator.registerFactory(() => TvSearchNotifier(searchTvSeries: locator()));

  locator.registerFactory(
    () => PopularTvSeriesNotifier(getPopularTvSeries: locator()),
  );

  locator.registerFactory(
    () => TopRatedTvSeriesNotifier(getTopRatedTvSeries: locator()),
  );

  locator.registerFactory(
    () => WatchlistTvNotifier(getWatchlistTvSeries: locator()),
  );

  locator.registerFactory(
    () => NowPlayingTvSeriesNotifier(getNowPlayingTvSeries: locator()),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => GetTvWatchlistStatus(locator()));
  locator.registerLazySingleton(() => SaveTvWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveTvWatchlist(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      tvRemoteDataSource: locator(),
      tvLocalDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(databaseHelper: locator()),
  );

  locator.registerLazySingleton<TvRemoteDataSource>(
    () => TvRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<TvLocalDataSource>(
    () => TvLocalDataSourceImpl(databaseHelper: locator()),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
