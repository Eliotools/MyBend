import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/src/enum/local_storage_key_enum.dart';
import 'package:mybend/src/features/bloc/local_storage_bloc.dart';
import 'package:mybend/src/helpers/local_storage_bloc.dart';
import 'package:mybend/src/model/activity.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class CreateActivityModale extends StatefulWidget {
  const CreateActivityModale({
    super.key,
  });

  @override
  State<CreateActivityModale> createState() => _CreateActivityModaleState();
}

class _CreateActivityModaleState extends State<CreateActivityModale> {
  String activityName = '';
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
                LocalStorageHelper.addItem(
                  LocalStorageKeyEnum.exercices,
                  Activity(name: activityName, time: activityTime!),
                );
                print('ok');
                context.read<LocalStorageBloc>().getItems();
                context.pop();
              }),
      ]));
}
