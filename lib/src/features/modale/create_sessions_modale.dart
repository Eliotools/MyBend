import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/src/enum/local_storage_key_enum.dart';
import 'package:mybend/src/features/bloc/local_storage_bloc.dart';
import 'package:mybend/src/helpers/local_storage_helper.dart';
import 'package:mybend/src/model/activity.dart';
import 'package:mybend/src/model/session.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class CreateSessions extends StatefulWidget {
  const CreateSessions({super.key, required this.list});
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
                LocalStorageHelper.addItem(
                  LocalStorageKeyEnum.sessions,
                  Session(name: name!, list: widget.list),
                );
                context.read<LocalStorageBloc>().getItems();
                context.pop();
              }),
      ]));
}
