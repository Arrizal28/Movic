import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../common/exception.dart';
import '../models/tv/tv_detail_response.dart';
import '../models/tv/tv_model.dart';
import '../models/tv/tv_response.dart';

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getNowPlayingTvSeries();

  Future<List<TvModel>> getPopularTvSeries();

  Future<List<TvModel>> getTopRatedTvSeries();

  Future<TvDetailResponse> getTvDetail(int id);

  Future<List<TvModel>> getTvRecommendations(int id);

  Future<List<TvModel>> searchTvSeries(String query);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {

  static const String ACCESS_TOKEN =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZTcwNzVkYWI2OGMyMWJmNTk5MjdmNjhiZjNlMTAyZCIsIm5iZiI6MTY2NDM3NzI5NC4yNzcsInN1YiI6IjYzMzQ2MWNlZWVjNGYzMDA4MDFiYTk1NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NiBsOL0Q0oYXhtzp6VxMXspVs__qjbBmQr3T3LBzC8A';
  static const String BASE_URL = 'https://api.themoviedb.org/3';

  late final http.Client client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<TvDetailResponse> getTvDetail(int id) async {
    try {
      final response = await client.get(Uri.parse('$BASE_URL/tv/$id'), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $ACCESS_TOKEN",
      });

      if (response.statusCode == 200) {
        return TvDetailResponse.fromJson(json.decode(response.body));
      } else {
        throw ServerException(message: response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error--> $e");
      }

      throw ServerException(message: "Failed to connect to server");
    }
  }

  @override
  Future<List<TvModel>> getTvRecommendations(int id) async {
    try {
      final response = await client
          .get(Uri.parse('$BASE_URL/tv/$id/recommendations'), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $ACCESS_TOKEN",
      });
      if (response.statusCode == 200) {
        return TvResponse.fromJson(json.decode(response.body)).tvList;
      } else {
        throw ServerException(message: response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error--> $e");
      }

      throw ServerException(message: "Failed to connect to server");
    }
  }

  @override
  Future<List<TvModel>> getNowPlayingTvSeries() async {
    try {
      final response = await client
          .get(Uri.parse('$BASE_URL/tv/airing_today'), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $ACCESS_TOKEN",
      });
      if (response.statusCode == 200) {
        return TvResponse.fromJson(json.decode(response.body))
            .tvList;
      } else {
        throw ServerException(message: response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException(message: "Failed to connect to server");
    }
  }

  @override
  Future<List<TvModel>> getPopularTvSeries() async {
    try {
      final response = await client
          .get(Uri.parse('$BASE_URL/tv/popular'), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $ACCESS_TOKEN",
      });
      if (response.statusCode == 200) {
        return TvResponse.fromJson(json.decode(response.body))
            .tvList;
      } else {
        throw ServerException(message: response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException(message: "Failed to connect to server");
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTvSeries() async {
    try {
      final response = await client
          .get(Uri.parse('$BASE_URL/tv/top_rated'), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $ACCESS_TOKEN",
      });
      if (response.statusCode == 200) {
        return TvResponse.fromJson(json.decode(response.body))
            .tvList;
      } else {
        throw ServerException(message: response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException(message: "Failed to connect to server");
    }
  }

  @override
  Future<List<TvModel>> searchTvSeries(String query) async {
    try {
      final response = await client.get(Uri.parse('$BASE_URL/search/tv?&query=$query'), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $ACCESS_TOKEN",
      });

      if(response.statusCode == 200) {
        return TvResponse.fromJson(json.decode(response.body)).tvList;
      } else {
        throw ServerException(message: response.body);
      }

    } catch (e) {
      debugPrint(e.toString());
      throw ServerException(message: "Failed to connect to server");
    }
  }

  debugPrint(String message) {
    if (kDebugMode) {
      print("Error--> $message");
    }
  }
}