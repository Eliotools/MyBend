import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mybend/src/helpers/helper.dart';
import 'package:mybend/src/model/activity.dart';
import 'package:mybend/src/model/home_state.dart';
import 'package:mybend/src/model/session.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> init() async {
    emit(HomeLoading());
    await initLocalStorage();
    final name = localStorage.getItem('name');
    if (name.isNullOrEmpty) {
      return emit(HomeLoginIn());
    }
    final exercices = Helper.tryDecod(localStorage.getItem('exercices'))
        .map((e) => Activity.fromJson(e as Map<String, Object?>))
        .toList();
    final sessions = Helper.tryDecod(localStorage.getItem('session'))
        .map((e) => Session.fromJson(e as Map<String, Object?>))
        .toList();
    final xp = localStorage.getItem('xp').isNotNullOrEmpty
        ? int.tryParse(localStorage.getItem('xp') ?? '') ?? 0
        : 0;
    final last = localStorage.getItem('history').isNotNullOrEmpty
        ? jsonDecode(localStorage.getItem('history') ?? '[]') as List
        : null;
    print(last);
    emit(HomeLoaded<
        ({
          List<Activity> exercies,
          List<Session> sessions,
          int xp,
          int? last,
          String name,
        })>(data: (
      exercies: exercices,
      sessions: sessions,
      xp: xp,
      last: last?.last['date'],
      name: name!
    )));
  }

  void setName(String name) {
    localStorage.setItem('name', name);
    init();
  }

  void createExo(Activity activity) {
    final activities = Helper.tryDecod(localStorage.getItem('exercices'));
    activities.add(activity.toJson());
    localStorage.setItem('exercices', jsonEncode(activities));
    init();
  }

  void createSession(Session session) {
    final sessions = Helper.tryDecod(localStorage.getItem('sessions'));
    sessions.add(session.toJson());
    localStorage.setItem('session', jsonEncode(sessions));
    init();
  }

  void addExp(int newXp) {
    final xp = int.tryParse(localStorage.getItem('xp') ?? '') ?? 0;
    localStorage.setItem('xp', (xp + newXp).toString());
    init();
  }

  void addHistory(String name, int time) {
    final history =
        jsonDecode(localStorage.getItem('history') ?? '[]') as List<Object?>;
    final date = DateTime.now().millisecondsSinceEpoch;

    history.add({'name': name, 'time': time, 'date': date});

    localStorage.setItem('history', jsonEncode(history));
    addExp(time);
    init();
  }

  void clear() {
    localStorage.setItem('session', '[]');
    localStorage.setItem('exercices', '[]');
    init();
  }
}
