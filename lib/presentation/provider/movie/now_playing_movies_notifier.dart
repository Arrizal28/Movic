import 'package:flutter/cupertino.dart';

import '../../../common/state_enum.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/movie/get_now_playing_movies.dart';

class NowPlayingMoviesNotifier extends ChangeNotifier {
  late final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMoviesNotifier({required this.getNowPlayingMovies});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Movie> _nowPlayingMovies = [];
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingMovies.execute();

    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _state = RequestState.Loaded;
        _nowPlayingMovies = moviesData;
        notifyListeners();
      },
    );
  }
}
