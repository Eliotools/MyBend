import 'package:flutter_dotenv/flutter_dotenv.dart';

class TmdbConfig {
  TmdbConfig._();

  static const baseUrl = 'https://api.themoviedb.org/3';
  static const imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  /// Reads `TMDB_API_KEY` from `.env`, with optional `--dart-define` fallback.
  static String get apiKey {
    final fromDotEnv = dotenv.env['TMDB_API_KEY']?.trim();
    if (fromDotEnv != null && fromDotEnv.isNotEmpty) return fromDotEnv;

    const fromDefine = String.fromEnvironment('TMDB_API_KEY');
    return fromDefine;
  }

  static String posterUrl(String posterPath) => '$imageBaseUrl$posterPath';
}
