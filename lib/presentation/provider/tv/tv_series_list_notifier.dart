import 'package:flutter/cupertino.dart';

import '../../../common/state_enum.dart';
import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/tv/get_now_playing_tv_series.dart';
import '../../../domain/usecases/tv/get_popular_tv_series.dart';
import '../../../domain/usecases/tv/get_top_rated_tv_series.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  late var _nowPlayingTvSeries = <Tv>[];
  List<Tv> get nowPlayingTvSeries => _nowPlayingTvSeries;

  late var _popularTvSeries = <Tv>[];
  List<Tv> get popularTvSeries => _popularTvSeries;

  late var _topRatedTvSeries = <Tv>[];
  List<Tv> get topRatedTvSeries => _topRatedTvSeries;

  late RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  late RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  late RequestState _topRatedState = RequestState.Empty;
  RequestState get topRatedState => _topRatedState;

  String _message = '';
  String get message => _message;

  TvSeriesListNotifier({
    required this.getNowPlayingTvSeries,
    required this.getPopularTvSeries,
    required this.getTopRatedTvSeries,
  });

  final GetNowPlayingTvSeries getNowPlayingTvSeries;
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;

  Future<void> fetchNowPlayingTvSeries() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTvSeries.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvSeries() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvSeries.execute();
    result.fold(
      (failure) {
        _popularState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _popularState = RequestState.Loaded;
        _popularTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvSeries() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvSeries.execute();
    result.fold(
      (failure) {
        _topRatedState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _topRatedState = RequestState.Loaded;
        _topRatedTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
