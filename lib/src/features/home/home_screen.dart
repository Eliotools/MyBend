import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'package:flutter/material.dart';
import 'package:mybend/src/features/bloc/local_storage_bloc.dart';
import 'package:mybend/src/features/history/history_page.dart';
import 'package:mybend/src/features/home/current_container.dart';
import 'package:mybend/src/features/home/exercices_container.dart';
import 'package:mybend/src/features/home/login_content.dart';
import 'package:mybend/src/features/home/sessions_container.dart';
import 'package:mybend/src/features/modale/add_activity_modale.dart';
import 'package:mybend/src/features/settings/settings_screen.dart';
import 'package:mybend/src/helpers/local_storage_helper.dart';
import 'package:mybend/src/model/data_dto.dart';
import 'package:mybend/src/model/home_state.dart';
import 'package:mybend/src/shared/base_page.dart';
import 'package:mybend/src/shared/container.dart';
import 'package:mybend/src/shared/extentions.dart';

final dateFormat = DateFormat('d/MM');

class HomePage extends BasePage<LocalStorageBloc, BendState> {
  const HomePage({super.key});

  static const name = 'home';

  @override
  Widget onBuild(BuildContext context, BendState state) => switch (state) {
        BendLoginIn() => const LoginContent(),
        BendLoaded<DataDto>(data: final data) => ListView(
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
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total XP : ${(data.xp % 1000).round()}'),
                          Text('Level : ${data.xp ~/ 1000}')
                        ]),
                    data.history.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                const Text('Dernère Séance '),
                                Text(dateFormat.format(
                                    data.history.last.date!))
                              ])
                        : const Text('Premère séance')
                  ],
                ),
              ),
              CustomContainer(
                  child: ExpansionTile(
                title: const Text('Exercices'),
                children: [
                ExerciceContainer(exercices: data.exercices)],
              )),
              CustomContainer(
                  child: ExpansionTile(
                title: const Text('Sessions'),
                children: [SessionContainer(sessions: data.sessions)],
              )),
              CurrentContainer(current: data.current),
             
              CustomContainer(
                  child: CupertinoButton(
                onPressed: () async => showDialog(
                    context: context,
                    builder: (context) => Dialog(
                        insetPadding: const EdgeInsets.all(8),
                        backgroundColor: context.them.colorScheme.surface,
                        child: const AddActivityModale())),
                child: const Text('Ajouter une activité'),
              )),
              CustomContainer(
                  child: CupertinoButton(
                onPressed: () => context.pushNamed(HistoryScreen.name),
                child: const Text("Voir l'historique"),
              )),
              Row(children: [
                CupertinoButton(
                  onPressed: () {
                    LocalStorageHelper.clear();
                    context.read<LocalStorageBloc>().getItems();
                  },
                  child: const Icon(Icons.clear),
                ),
                CupertinoButton(
                  onPressed: () => context.pushNamed(SettingsPage.name),
                  child: const Icon(Icons.settings),
                )
              ])
            ],
          ),
        BendState() => Text(state.toString()),
      };

}
  
