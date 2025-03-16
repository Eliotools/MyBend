
import 'package:mybend/src/model/activity.dart';
import 'package:mybend/src/model/history.dart';
import 'package:mybend/src/model/session.dart';
import 'package:mybend/src/model/streak.dart';

class DataDto {
  DataDto({
    this.name,
    this.exercices = const [],
    this.sessions = const [],
    this.xp = 0,
    this.history = const [],
    this.current,
    this.streak,
  });

  String? name;
  List<Activity> exercices;
  List<Session> sessions;
  int xp;
  List<History> history;
  Activity? current;
  Streak? streak;
}
