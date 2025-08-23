import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movic/domain/usecases/tv/get_tv_detail.dart';
import '../../../dummy_data/dummy_object.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvDetail usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvDetail(mockTvRepository);
  });

  const tId = 1;

  test('should get tv detail from repository', () async {
    // arrange
    when(mockTvRepository.getTvDetail(tId))
        .thenAnswer((_) async => Right(testTvDetail));

    // act
    final result = await usecase.execute(tId);

    // assert
    expect(result, Right(testTvDetail));
    verify(mockTvRepository.getTvDetail(tId)).called(1);
  });
}
