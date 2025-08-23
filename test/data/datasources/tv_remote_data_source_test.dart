import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movic/common/exception.dart';
import 'package:movic/data/datasources/tv_remote_data_source.dart';
import 'package:movic/data/models/tv/tv_detail_response.dart';
import 'package:movic/data/models/tv/tv_response.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const String ACCESS_TOKEN =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZTcwNzVkYWI2OGMyMWJmNTk5MjdmNjhiZjNlMTAyZCIsIm5iZiI6MTY2NDM3NzI5NC4yNzcsInN1YiI6IjYzMzQ2MWNlZWVjNGYzMDA4MDFiYTk1NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NiBsOL0Q0oYXhtzp6VxMXspVs__qjbBmQr3T3LBzC8A';
  const String BASE_URL = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSourceImpl;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourceImpl = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get now playing tv series', () {
    final dummyTvList = TvResponse.fromJson(
      json.decode(readJson('dummy_data/on_air_tv.json')),
    ).tvList;

    test('should return list of tv when response code is 200 ', () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/tv/airing_today'),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $ACCESS_TOKEN",
          },
        ),
      ).thenAnswer(
        (_) async =>
            http.Response(readJson('dummy_data/on_air_tv.json'), 200),
      );

      // act
      final result = await dataSourceImpl.getNowPlayingTvSeries();

      // assert
      expect(result, equals(dummyTvList));
    });

    test("should throw ServerException when response code isn't 200", () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/tv/airing_today'),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $ACCESS_TOKEN",
          },
        ),
      ).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      ); // Gunakan thenAnswer, bukan thenThrow

      // act & assert
      expect(
        () => dataSourceImpl.getNowPlayingTvSeries(),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('get recommendation tv series', () {
    final dummyTvList = TvResponse.fromJson(
      json.decode(readJson('dummy_data/tv_recommendations.json')),
    ).tvList;

    const tId = 1;

    test('should return list of tv when response code is 200 ', () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/tv/$tId/recommendations'),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $ACCESS_TOKEN",
          },
        ),
      ).thenAnswer(
        (_) async =>
            http.Response(readJson('dummy_data/tv_recommendations.json'), 200),
      );

      // act
      final result = await dataSourceImpl.getTvRecommendations(tId);

      // assert
      expect(result, equals(dummyTvList));
    });

    test(
      'should throw Server Exception when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.get(
            Uri.parse('$BASE_URL/tv/$tId/recommendations'),
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $ACCESS_TOKEN",
            },
          ),
        ).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        ); // Gunakan thenAnswer

        // act & assert
        expect(
          () => dataSourceImpl.getTvRecommendations(tId),
          throwsA(isA<ServerException>()),
        );
      },
    );
  });

  group('get tv detail', () {
    const tId = 1;
    final tTvDetail = TvDetailResponse.fromJson(
      json.decode(readJson('dummy_data/tv_detail.json')),
    );

    test('should return movie detail when the response code is 200', () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/tv/$tId'),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $ACCESS_TOKEN",
          },
        ),
      ).thenAnswer(
        (_) async => http.Response(readJson('dummy_data/tv_detail.json'), 200),
      );

      // act
      final result = await dataSourceImpl.getTvDetail(tId);

      // assert
      expect(result, equals(tTvDetail));
    });

    test(
      'should throw Server Exception when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.get(
            Uri.parse('$BASE_URL/tv/$tId'),
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $ACCESS_TOKEN",
            },
          ),
        ).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        ); // Gunakan thenAnswer

        // act & assert
        expect(
          () => dataSourceImpl.getTvDetail(tId),
          throwsA(isA<ServerException>()),
        );
      },
    );
  });

  group('search movies', () {
    final tSearchResult = TvResponse.fromJson(
      json.decode(readJson('dummy_data/search_spiderman_tv.json')),
    ).tvList;

    const tQuery = 'Spiderman';

    test('should return list of tv series when response code is 200', () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/search/tv?&query=$tQuery'),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $ACCESS_TOKEN",
          },
        ),
      ).thenAnswer(
        (_) async =>
            http.Response(readJson('dummy_data/search_spiderman_tv.json'), 200),
      );

      // act
      final result = await dataSourceImpl.searchTvSeries(tQuery);

      // assert
      expect(result, equals(tSearchResult));
    });

    test('should throw ServerException when response code is 404', () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/search/tv?&query=$tQuery'),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $ACCESS_TOKEN",
          },
        ),
      ).thenAnswer((_) async => http.Response('Not Found', 404));

      // act & assert
      expect(
        () => dataSourceImpl.searchTvSeries(tQuery),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
