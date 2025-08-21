import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';
import '../../entities/tv.dart';
import '../../repositories/tv_repository.dart';

class GetWatchlistTvSeries {
  final TvRepository repository;

  GetWatchlistTvSeries(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getWatchlistTvSeries();
  }
}