import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mybend/core/constantes/tmdb_config.dart';
import 'package:mybend/core/data/models/tmdb_movie.dart';

abstract class TmdbDataSource {
  Future<List<TmdbMovie>> searchMovies(String query);
}

class TmdbDataSourceImpl implements TmdbDataSource {
  TmdbDataSourceImpl({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  @override
  Future<List<TmdbMovie>> searchMovies(String query) async {
    if (query.trim().isEmpty) return [];
    if (TmdbConfig.apiKey.isEmpty) {
      throw Exception(
        'TMDB_API_KEY is missing. Copy .env.example to .env and set your key.',
      );
    }

    final uri = Uri.parse('${TmdbConfig.baseUrl}/search/movie').replace(
      queryParameters: {
        'api_key': TmdbConfig.apiKey,
        'query': query.trim(),
        'language': 'fr-FR',
      },
    );

    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw Exception('TMDB request failed (${response.statusCode})');
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final results = body['results'] as List<dynamic>? ?? [];

    return results
        .map((item) => TmdbMovie.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
