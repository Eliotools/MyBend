import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class Streak {
  Streak({required this.date, required this.streak});

  DateTime date;
  int streak;

  factory Streak.fromJson(Map<String, Object?> data) => Streak(
        date: DateTime.fromMillisecondsSinceEpoch(
            int.parse(data['date'].toString())),
        streak: int.parse(data['streak'].toString()),
      );

  static Streak? fromJsonOrNull(Map<String, Object?>? data) =>
      data.isNotNull ? Streak.fromJson(data!) : null;

  Map<String, Object?> toJson() => {
        'date': date.millisecondsSinceEpoch,
        'streak': streak,
      };
}
