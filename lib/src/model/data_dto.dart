import 'package:mybend/src/model/activity.dart';
import 'package:mybend/src/model/session.dart';

class DataDto {
  DataDto({
    this.name,
    this.exercices = const [],
    this.sessions = const [],
    this.xp = 0,
    this.last = 0,
  });

  String? name;
  List<Activity> exercices;
  List<Session> sessions;
  int xp;
  int? last;
}
