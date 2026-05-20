import 'package:wyatt_type_utils/wyatt_type_utils.dart';

enum ContentType {
  book,
  movie,
}

class Content {
  Content(
      {required this.name,
      required this.type,
      required this.time,
      required this.comments});

  factory Content.fromJson(Map<String, Object?> data) => Content(
      name: data['name'].isNotNull ? data['name'].toString() : 'not found',
      type: data['type'].isNotNull
          ? ContentType.values.byName(data['type'].toString())
          : ContentType.book,
      time: data['time'].isNotNull ? int.parse(data['time'].toString()) : 0,
      comments: data['comments'].isNotNull
          ? data['comments'].toString()
          : 'not found');

  static Content? fromJsonOrNull(Map<String, Object?>? data) => data.isNotNull
      ? Content(
          name: data!['name'].isNotNull ? data['name'].toString() : 'not found',
          type: data['type'].isNotNull
              ? ContentType.values.byName(data['type'].toString())
              : ContentType.book,
          time: data['time'].isNotNull ? int.parse(data['time'].toString()) : 0,
          comments: data['comments'].isNotNull
              ? data['comments'].toString()
              : 'not found')
      : null;

  Map<String, Object?> toJson() => {
        'name': name,
        'type': type.name,
        'time': time,
        'comments': comments,
      };

  final String name;
  final ContentType type;
  final int time;
  final String comments;
}
