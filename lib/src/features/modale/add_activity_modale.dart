import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/src/enum/local_storage_key_enum.dart';
import 'package:mybend/src/helpers/local_storage_helper.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class AddActivityModale extends StatefulWidget {
  const AddActivityModale({super.key, this.name, this.time});

  final String? name;
  final int? time;

  @override
  State<AddActivityModale> createState() => AddActivityModaleState();
}

class AddActivityModaleState extends State<AddActivityModale> {
  String? name;
  int? time;
  final nameController = TextEditingController();
  final timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      nameController.text = widget.name ?? '';
      timeController.text = widget.time?.toString() ?? '';
    });
  }

  @override
  Widget build(BuildContext context) => AspectRatio(
      aspectRatio: 1.5,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Ajouter une Actiivté'),
        TextField(
          controller: nameController,
          onChanged: (value) => setState(() => name = value),
          decoration: const InputDecoration(hintText: 'Nom'),
        ),
        TextField(
          keyboardType: TextInputType.number,
          controller: timeController,
          onChanged: (value) => setState(() => time = int.parse(value)),
          decoration: const InputDecoration(hintText: 'Durée'),
        ),
        if (nameController.text.isNotNullOrEmpty &&
            timeController.text.isNotNullOrEmpty)
          CupertinoButton(
              child: const Text('Ajouter'),
              onPressed: () {
                LocalStorageHelper.addItem(LocalStorageKeyEnum.history, {
                  'name': nameController.text,
                  'time': timeController.text,
                  'date': DateTime.now().millisecondsSinceEpoch,
                });

                context.pop();
              }),
      ]));
}
