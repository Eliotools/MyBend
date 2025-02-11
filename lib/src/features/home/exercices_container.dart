import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/src/enum/local_storage_key_enum.dart';
import 'package:mybend/src/features/activity/activity_page.dart';
import 'package:mybend/src/features/modale/create_sessions_modale.dart';
import 'package:mybend/src/features/modale/create_activity_modale.dart';
import 'package:mybend/src/helpers/helper.dart';
import 'package:mybend/src/features/bloc/local_storage_bloc.dart';
import 'package:mybend/src/helpers/local_storage_bloc.dart';
import 'package:mybend/src/model/activity.dart';
import 'package:mybend/src/shared/extentions.dart';

class ExerciceContainer extends StatefulWidget {
  const ExerciceContainer(
      {super.key, required this.exercices});

  
  final List<Activity> exercices;

  @override
  State<ExerciceContainer> createState() => _ExerciceContainerState();
}

class _ExerciceContainerState extends State<ExerciceContainer> {
  final List<Activity> selected = [];

  @override
  Widget build(BuildContext context) => ListView(
        shrinkWrap: true,
        children: [
          widget.exercices.isNotEmpty
              ? GridView.count(
                  childAspectRatio: 2,
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: widget.exercices
                      .map((e) => InkWell(
                          onTap: () => setState(() {
                                selected.add(e);
                              }),
                          child: Column(
                            children: [
                              Text(e.name),
                              Row(
                                children: Helper.findAllIndexWhere(e, selected)
                                    .map((e) => Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.orange,
                                        ),
                                        child: Text(e.toString(),
                                            style: const TextStyle(
                                                color: Colors.white))))
                                    .toList(),
                              )
                            ],
                          )))
                      .toList(),
                )
              : const Text(
                  "Pas d'exerces enregisté",
                  textAlign: TextAlign.center,
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CupertinoButton(
                      onPressed: () async => showDialog(
                          context: context,
                          builder: (context) => Dialog(
                              insetPadding: const EdgeInsets.all(8),
                              backgroundColor: context.them.colorScheme.surface,
                              child: const CreateActivityModale())),
                      child: const Icon(Icons.add)),
                  CupertinoButton(
                      onPressed: () async => selected.isEmpty
                          ? null
                          : showDialog(
                          context: context,
                          builder: (context) => Dialog(
                              insetPadding: const EdgeInsets.all(8),
                              backgroundColor: context.them.colorScheme.surface,
                                  child: CreateSessions(list: selected))),
                      child: Icon(
                        Icons.inventory,
                        color: selected.isEmpty ? Colors.grey : Colors.white,
                      )),
                ],
              ),
              CupertinoButton(
                  child: const Text('Clear'),
                  onPressed: () => setState(() => selected.clear())),
              CupertinoButton(
                  child: const Text('Lancer'),
                  onPressed: () => selected.isEmpty
                      ? null
                      : context
                          .pushNamed(ActivityPage.name, extra: selected)
                          .then((value) {
                          final time = selected
                              .map((e) => e.time)
                              .reduce((a, b) => a + b);
                          LocalStorageHelper.addItem(
                              LocalStorageKeyEnum.history, {
                            'name': 'Exercice',
                            'time': time,
                            'date': DateTime.now().millisecondsSinceEpoch,
                          });
                          LocalStorageHelper.addIntItem(
                              LocalStorageKeyEnum.xp, time ~/ 6);
                          context.read<LocalStorageBloc>().getItems();
                        })),
            ],
          )
        ],
      );
}
