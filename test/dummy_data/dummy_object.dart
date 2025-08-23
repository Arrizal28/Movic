

import 'package:movic/data/models/movie/movie_table.dart';
import 'package:movic/data/models/tv/tv_table.dart';
import 'package:movic/domain/entities/genre.dart';
import 'package:movic/domain/entities/movie.dart';
import 'package:movic/domain/entities/movie_detail.dart';
import 'package:movic/domain/entities/tv.dart';
import 'package:movic/domain/entities/tv_detail.dart';

final testMovieTable = MovieTable(
    id: 1, title: "title", posterPath: "posterPath", overview: "overview");

const testTvTable = TvTable(
    id: 1, title: "title", posterPath: "posterPath", overview: "overview");

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1, releaseDate: '',
);

final testTvDetail = TvDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalName: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: const [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
  'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  voteAverage: 7.2,
  voteCount: 13507,
  video: false,
);

final testTvSeries = Tv(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: const [14, 28],
  id: 557,
  originalName: 'Spider-Man',
  overview:
  'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  name: 'Spider-Man',
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testTvList = [testTvSeries];

