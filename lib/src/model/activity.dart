import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class Activity {
  Activity({required this.name, required this.time});

  factory Activity.fromJson(Map<String, Object?> data) => Activity(
      name: data['name'].isNotNull ? data['name'].toString() : 'not found',
      time: int.parse(data['time'].toString()));

  final String name;
  final int time;

  Map<String, Object?> toJson() => {'name': name, 'time': time.toString()};
}
