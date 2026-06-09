import 'package:mybend/core/constantes/tmdb_config.dart';

class TmdbMovie {
  const TmdbMovie({
    required this.id,
    required this.title,
    this.posterPath,
  });

  factory TmdbMovie.fromJson(Map<String, dynamic> json) => TmdbMovie(
        id: json['id'] as int,
        title: json['title'] as String? ?? '',
        posterPath: json['poster_path'] as String?,
      );

  final int id;
  final String title;
  final String? posterPath;

  String? get posterUrl =>
      posterPath != null ? TmdbConfig.posterUrl(posterPath!) : null;
}
