enum ContentType {
  book,
  movie,
}

class Content {
  Content({
    this.id = -1,
    required this.name,
    required this.type,
    required this.time,
    this.comments,
  });

  factory Content.fromJson(Map<String, Object?> data) => Content(
        id: data['id'] != null ? int.parse(data['id'].toString()) : -1,
        name: data['name']?.toString() ?? '',
        type: data['type'] != null
            ? ContentType.values.byName(data['type'].toString())
            : ContentType.book,
        time: data['time'] != null ? int.parse(data['time'].toString()) : 0,
        comments: data['comments']?.toString(),
      );

  final int id;
  final String name;
  final ContentType type;
  final int time;
  final String? comments;

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'type': type.name,
        'time': time,
        'comments': comments,
      };
}
