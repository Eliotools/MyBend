import 'package:mybend/core/data/datasources/tmdb_datasource.dart';
import 'package:mybend/core/data/models/tmdb_movie.dart';

abstract class TmdbRepository {
  Future<String?> getMoviePosterUrl(String movieName);
  Future<List<TmdbMovie>> searchMovies(String query);
}

class TmdbRepositoryImpl implements TmdbRepository {
  TmdbRepositoryImpl({required TmdbDataSource tmdbDataSource})
      : _tmdbDataSource = tmdbDataSource;

  final TmdbDataSource _tmdbDataSource;

  @override
  Future<List<TmdbMovie>> searchMovies(String query) =>
      _tmdbDataSource.searchMovies(query);

  @override
  Future<String?> getMoviePosterUrl(String movieName) async {
    final movies = await searchMovies(movieName);
    if (movies.isEmpty) return null;

    for (final movie in movies) {
      if (movie.posterUrl != null) return movie.posterUrl;
    }

    return null;
  }
}
