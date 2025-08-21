import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';
import '../../entities/tv_detail.dart';
import '../../repositories/tv_repository.dart';

class RemoveTvWatchlist {

  RemoveTvWatchlist(this.repository);

  final TvRepository repository;

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.removeWatchlist(tv);
  }
}