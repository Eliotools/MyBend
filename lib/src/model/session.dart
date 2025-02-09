import 'package:mybend/src/model/activity.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class Session {
  Session({required this.name, required this.list});

  factory Session.fromJson(Map<String, Object?> data) => Session(
      name: data['name'].isNotNull ? data['name'].toString() : 'not found',
      list: data['list'].isNotNull
          ? (data['list'] as List<Object?>)
              .map((e) => Activity.fromJson(e as Map<String, Object?>))
              .toList()
          : []);

  Map<String, Object?> toJson() =>
      {'name': name, 'list': list.map((e) => e.toJson()).toList()};

  int get totalTime => list.map((e) => e.time).reduce((a, b) => a + b);

  @override
  String toString() => '$name, ${list.map((e) => e.name)}';
  final String name;
  final List<Activity> list;
}
