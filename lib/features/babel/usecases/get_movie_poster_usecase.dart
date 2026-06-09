import 'package:mybend/core/data/repositories/tmdb_repository.dart';

class GetMoviePosterUseCase {
  GetMoviePosterUseCase(this._tmdbRepository);

  final TmdbRepository _tmdbRepository;

  Future<String?> call(String movieName) =>
      _tmdbRepository.getMoviePosterUrl(movieName);
}
