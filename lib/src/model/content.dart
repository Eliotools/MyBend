import 'package:wyatt_type_utils/wyatt_type_utils.dart';

enum ContentType {
  book,
  movie,
}

class ObjectWithId {
  ObjectWithId({this.id = -1});

  int id;
}

class Content extends ObjectWithId {
  Content(
      {
    super.id,
    required this.name,
    required this.type,
    required this.time,
    this.comments,
  });

  factory Content.fromJson(Map<String, Object?> data) => Content(
      id: data['id'].isNotNull ? int.parse(data['id'].toString()) : -1,
      name: data['name'].isNotNull ? data['name'].toString() : 'not found',
      type: data['type'].isNotNull
          ? ContentType.values.byName(data['type'].toString())
          : ContentType.book,
      time: data['time'].isNotNull ? int.parse(data['time'].toString()) : 0,
      comments: data['comments'].isNotNull
          ? data['comments'].toString()
          : 'not found');

  factory Content.empty() => Content(
      name: '', type: ContentType.book, time: DateTime.now().secondsSinceEpoch);

  static Content? fromJsonOrNull(Map<String, Object?>? data) => data.isNotNull
      ? Content(
          id: data!['id'].isNotNull ? int.parse(data['id'].toString()) : -1,
          name: data['name'].isNotNull ? data['name'].toString() : 'not found',
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
        'id': id,
      };

  String name;
  ContentType type;
  int time;
  String? comments;
}
