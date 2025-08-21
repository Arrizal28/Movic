import 'package:flutter/cupertino.dart';

import '../../../common/state_enum.dart';
import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/tv/get_watchlist_tv_series.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  RequestState _watchlistTvState = RequestState.Empty;
  RequestState get watchlistTvState => _watchlistTvState;

  List<Tv> _watchlistTvSeries = [];
  List<Tv> get watchlistTvSeries => _watchlistTvSeries;

  String _message = '';
  String get message => _message;

  WatchlistTvNotifier({required this.getWatchlistTvSeries});

  final GetWatchlistTvSeries getWatchlistTvSeries;

  Future<void> fetchWatchlistTvSeries() async {
    _watchlistTvState = RequestState.Loading;
    notifyListeners();
    final result = await getWatchlistTvSeries.execute();
    result.fold((failure) {
      _watchlistTvState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvSeries) {
      _watchlistTvState = RequestState.Loaded;
      _watchlistTvSeries = tvSeries;
      notifyListeners();
    });
  }

}