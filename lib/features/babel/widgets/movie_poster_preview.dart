import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mybend/core/di/injections.dart';
import 'package:mybend/features/babel/usecases/get_movie_poster_usecase.dart';

class MoviePosterPreview extends StatefulWidget {
  const MoviePosterPreview({
    super.key,
    required this.movieName,
    this.initialUrl,
    this.onPosterUrlChanged,
    this.height = 160,
  });

  final String movieName;
  final String? initialUrl;
  final ValueChanged<String?>? onPosterUrlChanged;
  final double height;

  @override
  State<MoviePosterPreview> createState() => _MoviePosterPreviewState();
}

class _MoviePosterPreviewState extends State<MoviePosterPreview> {
  Timer? _debounce;
  String? _posterUrl;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _posterUrl = widget.initialUrl;
    _scheduleFetch(widget.movieName);
  }

  @override
  void didUpdateWidget(MoviePosterPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.movieName != widget.movieName ||
        oldWidget.initialUrl != widget.initialUrl) {
      _posterUrl = widget.initialUrl;
      _scheduleFetch(widget.movieName);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _scheduleFetch(String movieName) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () => _fetch(movieName));
  }

  Future<void> _fetch(String movieName) async {
    if (movieName.trim().isEmpty) {
      setState(() {
        _posterUrl = null;
        _loading = false;
      });
      widget.onPosterUrlChanged?.call(null);
      return;
    }

    setState(() => _loading = true);

    try {
      final url = await getIt<GetMoviePosterUseCase>().call(movieName.trim());
      if (!mounted) return;
      setState(() {
        _posterUrl = url;
        _loading = false;
      });
      widget.onPosterUrlChanged?.call(url);
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return SizedBox(
        height: widget.height,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_posterUrl == null) return const SizedBox.shrink();

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        _posterUrl!,
        height: widget.height,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
      ),
    );
  }
}
