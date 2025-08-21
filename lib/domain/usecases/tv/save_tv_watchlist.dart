import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';
import '../../entities/tv_detail.dart';
import '../../repositories/tv_repository.dart';

class SaveTvWatchlist {

  SaveTvWatchlist(this.repository);

  final TvRepository repository;

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.saveWatchlist(tv);
  }
}