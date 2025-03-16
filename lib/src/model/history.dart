import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class History {
  History({required this.name, required this.time, required this.date});

  factory History.fromJson(Map<String, Object?> data) {
    var history = History(
        name: data['name'].isNotNull ? data['name'].toString() : 'not found',
        time: data['time'].isNotNull
            ? int.tryParse(data['time'].toString())
            : null,
        date: data['date'].isNotNull
            ? DateTime.fromMillisecondsSinceEpoch(
                int.tryParse(data['date'].toString()) ?? 0)
            : null);
    return history;
  }

  Map<String, Object?> toJson() =>
      {'name': name, 'time': time, 'date': date?.millisecondsSinceEpoch};

  @override
  String toString() => "{'name': $name, 'time': $time, 'date': $date}";

  final String name;
  final int? time;
  final DateTime? date;
}
