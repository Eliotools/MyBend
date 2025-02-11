import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/src/enum/local_storage_key_enum.dart';
import 'package:mybend/src/features/bloc/local_storage_bloc.dart';
import 'package:mybend/src/helpers/local_storage_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class AddActivityModale extends StatefulWidget {
  const AddActivityModale({super.key});

  @override
  State<AddActivityModale> createState() => AddActivityModaleState();
}

class AddActivityModaleState extends State<AddActivityModale> {
  String? name;
  int? time;

  @override
  Widget build(BuildContext context) => AspectRatio(
      aspectRatio: 1.5,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Ajouter une Actiivté'),
        TextField(
          onChanged: (value) => setState(() => name = value),
          decoration: const InputDecoration(hintText: 'Nom'),
        ),
        TextField(
          keyboardType: TextInputType.number,
          onChanged: (value) => setState(() => time = int.parse(value)),
          decoration: const InputDecoration(hintText: 'Durée'),
        ),
        if (name.isNotNullOrEmpty && time.isNotNull)
          CupertinoButton(
              child: const Text('Ajouter'),
              onPressed: () {
                LocalStorageHelper.addItem(LocalStorageKeyEnum.history, {
                  'name': name,
                  'time': time,
                  'date': DateTime.now().millisecondsSinceEpoch,
                });

                context.pop();
              }),
      ]));
}
