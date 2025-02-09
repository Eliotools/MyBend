import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/src/features/activity/activity_page.dart';
import 'package:mybend/src/features/home/home_cubit.dart';
import 'package:mybend/src/helpers/helper.dart';
import 'package:mybend/src/model/activity.dart';
import 'package:mybend/src/model/session.dart';
import 'package:mybend/src/shared/extentions.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class ExerciceContainer extends StatefulWidget {
  const ExerciceContainer(
      {super.key, required this.exercices, required this.action});

  final void Function(Object activity) action;
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
                      onPressed: () => showDialog(
                          context: context,
                          builder: (context) => Dialog(
                              insetPadding: const EdgeInsets.all(8),
                              backgroundColor: context.them.colorScheme.surface,
                              child: AddActivityModal(
                                action: widget.action,
                              ))),
                      child: const Icon(Icons.add)),
                  CupertinoButton(
                      onPressed: () => showDialog(
                          context: context,
                          builder: (context) => Dialog(
                              insetPadding: const EdgeInsets.all(8),
                              backgroundColor: context.them.colorScheme.surface,
                              child: CreateSessions(
                                action: widget.action,
                                list: selected,
                              ))),
                      child: const Icon(Icons.inventory)),
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
                          .pushNamed(
                            ActivityPage.name,
                            extra: selected,
                          )
                          .then((e) => context.read<HomeCubit>().addHistory(
                              'Exercices',
                              selected
                                      .map((e) => e.time)
                                      .reduce((a, b) => a + b) ~/
                                  6))),
            ],
          ),
        ],
      );
}

class AddActivityModal extends StatefulWidget {
  const AddActivityModal({super.key, required this.action});
  final void Function(Object data) action;

  @override
  State<AddActivityModal> createState() => _AddActivityModalState();
}

class _AddActivityModalState extends State<AddActivityModal> {
  String? activityName;
  int? activityTime;

  @override
  Widget build(BuildContext context) => AspectRatio(
      aspectRatio: 1.5,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Ajouter un activié'),
        TextField(
          onChanged: (value) => setState(() => activityName = value),
          decoration: const InputDecoration(hintText: 'Nom'),
        ),
        TextField(
          keyboardType: TextInputType.number,
          onChanged: (value) => setState(() => activityTime = int.parse(value)),
          decoration: const InputDecoration(hintText: 'Durée'),
        ),
        if (activityName.isNotNullOrEmpty && activityTime.isNotNull)
          CupertinoButton(
              child: const Text('Ajouter'),
              onPressed: () {
                widget.action(
                  Activity(name: activityName!, time: activityTime!),
                );
                context.pop();
              }),
      ]));
}

class CreateSessions extends StatefulWidget {
  const CreateSessions({super.key, required this.action, required this.list});
  final void Function(Object data) action;
  final List<Activity> list;

  @override
  State<CreateSessions> createState() => CcreateSessionsState();
}

class CcreateSessionsState extends State<CreateSessions> {
  String? name;
  @override
  Widget build(BuildContext context) => AspectRatio(
      aspectRatio: 1.5,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Créer une sessions'),
        TextField(
          onChanged: (value) => setState(() => name = value),
          decoration: const InputDecoration(hintText: 'Nom'),
        ),
        if (name.isNotNullOrEmpty)
          CupertinoButton(
              child: const Text('Ajouter'),
              onPressed: () {
                widget.action(
                  Session(name: name!, list: widget.list),
                );
                context.pop();
              }),
      ]));
}
