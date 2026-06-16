import 'package:flutter/material.dart';

enum ContentType {
  book('book', Icons.book),
  movie('movie', Icons.movie),
  game('game', Icons.games);

  const ContentType(this.name, this.icon);

  final String name;
  final IconData icon;
}

enum ContentStatus {
  todo('Todo'),
  doing('Doing'),
  done('Done');

  const ContentStatus(this.label);

  final String label;
}

class Content {
  Content({
    this.id = -1,
    this.name,
    this.type = ContentType.book,
    this.time = 0,
    this.rating = 0,
    this.status = ContentStatus.todo,
    this.comment,
    this.imageUrl,
  });

  factory Content.fromJson(Map<String, Object?> data) {
    final rawRating = data['rate'];
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
          ? ContentStatus.values
              .where((e) => e.label == data['status'].toString())
              .first
          : ContentStatus.todo,
      comment: data['comment']?.toString(),
      imageUrl: data['imageUrl']?.toString(),
    );
  }


  factory Content.empty() => Content();

  Content copyWith({
   String? name,
   ContentType? type,
   int? time,
   int? rating,
   ContentStatus? status,
   String? comment,
   String? imageUrl,
  }) => Content(
    id : id,
    name : name ?? this.name,
    type : type ?? this.type,
    time : time ?? this.time,
    rating : rating ?? this.rating,
    status : status ?? this.status,
    comment : comment ?? this.comment,
    imageUrl : imageUrl ?? this.imageUrl,
  );

  final int id;
  final String? name;
  final ContentType type;
  final int time;
  final int rating;
  final ContentStatus status;
  final String? comment;
  final String? imageUrl;

  Map<String, Object?> toJson() {
    final res = {
      'id': id.toString(),
      'time': time,
      'name': name,
      'type': type.name,
      'rate': rating,
      'status': status.label,
      'comment': comment,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
    return res;
  }
}
