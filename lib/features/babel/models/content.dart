import 'package:flutter/material.dart';

enum ContentType {
  book('Livre', Icons.book),
  movie('Film', Icons.movie),
  jeux('Jeux', Icons.games);

  const ContentType(this.name, this.icon);

  final String name;
  final IconData icon;
}

enum ContentStatus {
  todo('Do'),
  doing('Doing'),
  done('Done');

  const ContentStatus(this.label);

  final String label;
}

class Content {
  Content({
    this.id = -1,
    required this.name,
    required this.type,
    required this.time,
    this.rating = 0,
    this.status = ContentStatus.todo,
    this.comments,
    this.imageUrl,
  });

  factory Content.fromJson(Map<String, Object?> data) {
    final rawRating = data['rating'];
    final rating = rawRating != null ? int.parse(rawRating.toString()) : 0;

    return Content(
      id: data['id'] != null ? int.parse(data['id'].toString()) : -1,
      name: data['name']?.toString() ?? '',
      type: data['type'] != null
          ? ContentType.values
              .firstWhere((e) => e.name == data['type'].toString())
          : ContentType.book,
      rating: rating.clamp(0, 5),
      time: data['time'] != null ? int.parse(data['time'].toString()) : 0,
      status: data['status'] != null
          ? ContentStatus.values.byName(data['status'].toString())
          : ContentStatus.todo,
      comments: data['comments']?.toString(),
      imageUrl: data['imageUrl']?.toString(),
    );
  }

  final int id;
  final String name;
  final ContentType type;
  final int time;
  final int rating;
  final ContentStatus status;
  final String? comments;
  final String? imageUrl;

  Map<String, Object?> toJson() => {
        'id': id,
        'time': time,
        'name': name,
        'type': type.name,
        'rating': rating,
        'status': status.name,
        'comments': comments,
        if (imageUrl != null) 'imageUrl': imageUrl,
      };
}
