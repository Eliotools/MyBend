import 'package:mybend/src/model/content.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class Activity extends ObjectWithId {
  Activity({super.id = -1, required this.name, required this.time});

  factory Activity.fromJson(Map<String, Object?> data) => Activity(
      id: data['id'].isNotNull ? int.parse(data['id'].toString()) : -1,
      name: data['name'].isNotNull ? data['name'].toString() : 'not found',
      time: int.parse(data['time'].toString()));

  static Activity? fromJsonOrNull(Map<String, Object?>? data) => data.isNotNull
      ? Activity(
          id: data!['id'].isNotNull ? int.parse(data['id'].toString()) : -1,

          name: data!['name'].isNotNull ? data['name'].toString() : 'not found',
          time: int.parse(data['time'].toString()))
      : null;

  final String name;
  final int time;

  Map<String, Object?> toJson() => {'name': name, 'time': time.toString()};
}
