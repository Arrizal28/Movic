import 'package:flutter/cupertino.dart';

import '../../../common/state_enum.dart';
import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/tv/search_tv_series.dart';

class TvSearchNotifier extends ChangeNotifier {
  final SearchTvSeries searchTvSeries;

  TvSearchNotifier({required this.searchTvSeries});

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<Tv> _searchResult = [];

  List<Tv> get searchResult => _searchResult;

  String _message = '';

  String get message => _message;

  Future<void> fetchTvSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvSeries.execute(query);
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _state = RequestState.Loaded;
        _searchResult = data;
        notifyListeners();
      },
    );
  }

  Future<void> resetState() {
    _state = RequestState.Empty;
    _message = '';
    _searchResult = [];
    return Future.value();
  }
}
