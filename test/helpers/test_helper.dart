
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:movic/data/datasources/db/database_helper.dart';
import 'package:movic/data/datasources/movie_local_data_source.dart';
import 'package:movic/data/datasources/movie_remote_data_source.dart';
import 'package:movic/data/datasources/tv_local_data_source.dart';
import 'package:movic/data/datasources/tv_remote_data_source.dart';
import 'package:movic/domain/repositories/movie_repository.dart';
import 'package:movic/domain/repositories/tv_repository.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
