import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'package:flutter/material.dart';
import 'package:mybend/src/features/history/history_page.dart';
import 'package:mybend/src/features/home/exercices_container.dart';
import 'package:mybend/src/features/home/home_cubit.dart';
import 'package:mybend/src/features/home/login_content.dart';
import 'package:mybend/src/features/home/sessions_container.dart';
import 'package:mybend/src/model/activity.dart';
import 'package:mybend/src/model/home_state.dart';
import 'package:mybend/src/model/session.dart';
import 'package:mybend/src/shared/container.dart';
import 'package:wyatt_bloc_helper/wyatt_bloc_helper.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

final dateFormat = DateFormat('d/MM');

class HomeScreen extends CubitScreen<HomeCubit, HomeState> {
  const HomeScreen({super.key});

  static const name = 'home';

  @override
  create(BuildContext context) => HomeCubit()..init();

  @override
  Widget onBuild(BuildContext context, HomeState state) => switch (state) {
        HomeLoginIn() => const LoginContent(),
        HomeLoaded<
              ({
                List<Activity> exercies,
                List<Session> sessions,
                int xp,
                int? last,
                String name
              })>(data: final data) =>
          HomeContent(data: data),
        _ => Text(state.toString()),
      };
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key, required this.data});

  final ({
    List<Activity> exercies,
    List<Session> sessions,
    int xp,
    int? last,
    String name
  }) data;

  @override
  Widget build(BuildContext context) => ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          CustomContainer(
            child: Column(
              children: [
                Text('Bonjour ${data.name}'),
                Image.asset(
                    'assets/sprites/lvl-${(data.xp ~/ 1000) + 1}/front.gif')
              ],
            ),
          ),
          CustomContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Total XP : ${(data.xp % 1000).round()}'),
                  Text('Level : ${data.xp ~/ 1000}')
                ]),
                data.last.isNotNull
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            const Text('Dernère Séance '),
                            Text(dateFormat.format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    data.last ?? 0)))
                          ])
                    : const Text('Premère séance')
              ],
            ),
          ),
          CustomContainer(
              child: ExpansionTile(
            title: const Text('Exercices'),
            children: [
              ExerciceContainer(
                exercices: data.exercies,
                action: (data) {
                  if (data is Activity) {
                    context.read<HomeCubit>().createExo(data);
                  } else if (data is Session) {
                    context.read<HomeCubit>().createSession(data);
                  }
                },
              )
            ],
          )),
          CustomContainer(
              child: ExpansionTile(
            title: const Text('Sessions'),
            children: [SessionContainer(sessions: data.sessions)],
          )),
          CustomContainer(
              child: CupertinoButton(
            onPressed: () => context.read<HomeCubit>().addExp(10),
            child: const Text('Enregister une activité'),
          )),
          CustomContainer(
              child: CupertinoButton(
            onPressed: () => context.pushNamed(HistoryPage.name),
            child: const Text("Voir l'historique"),
          )),
          Row(children: [
            CupertinoButton(
              onPressed: () => context.read<HomeCubit>().clear(),
              child: const Icon(Icons.clear),
            )
          ])
        ],
      );
}
