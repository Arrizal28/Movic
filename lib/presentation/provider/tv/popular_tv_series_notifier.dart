import 'package:flutter/cupertino.dart';

import '../../../common/state_enum.dart';
import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/tv/get_popular_tv_series.dart';

class PopularTvSeriesNotifier extends ChangeNotifier {
  late final GetPopularTvSeries getPopularTvSeries;

  PopularTvSeriesNotifier({required this.getPopularTvSeries});

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<Tv> _popularTvSeries = [];

  List<Tv> get popularTvSeries => _popularTvSeries;

  String _message = '';

  String get message => _message;

  Future<void> fetchPopularTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvSeries.execute();
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _state = RequestState.Loaded;
        _popularTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
