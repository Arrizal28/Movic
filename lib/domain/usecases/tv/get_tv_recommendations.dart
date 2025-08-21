import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';
import '../../entities/tv.dart';
import '../../repositories/tv_repository.dart';

class GetTvRecommendations {

  GetTvRecommendations(this.repository);

  final TvRepository repository;

  Future<Either<Failure, List<Tv>>> execute(int id) {
    return repository.getTvRecommendations(id);
  }
}