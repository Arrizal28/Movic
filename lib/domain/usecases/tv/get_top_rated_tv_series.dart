import 'package:dartz/dartz.dart';
import 'package:movic/domain/entities/tv.dart';
import 'package:movic/domain/repositories/tv_repository.dart';

import '../../../common/failure.dart';

class GetTopRatedTvSeries {
  final TvRepository repository;

  GetTopRatedTvSeries(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopRatedTvSeries();
  }
}