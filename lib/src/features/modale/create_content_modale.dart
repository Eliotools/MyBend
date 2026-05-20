import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/src/enum/local_storage_key_enum.dart';
import 'package:mybend/src/features/bloc/local_storage_bloc.dart';
import 'package:mybend/src/helpers/local_storage_helper.dart';
import 'package:mybend/src/model/content.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class CreateContentModale extends StatefulWidget {
  const CreateContentModale({
    super.key,
  });

  @override
  State<CreateContentModale> createState() => _CreateContentModaleState();
}

class _CreateContentModaleState extends State<CreateContentModale> {
  String contentName = '';
  ContentType? contentType;
  String? comments;

  @override
  Widget build(BuildContext context) => AspectRatio(
      aspectRatio: 1.5,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Ajouter un contenu'),
        TextField(
          onChanged: (value) => setState(() => contentName = value),
          decoration: const InputDecoration(hintText: 'Nom'),
        ),
        DropdownButton<ContentType>(
          items: ContentType.values
              .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
              .toList(),
          onChanged: (value) => setState(() => contentType = value),
        ),
        TextField(
          onChanged: (value) => setState(() => comments = value),
          decoration: const InputDecoration(hintText: 'Commentaires'),
        ),
        if (contentName.isNotNullOrEmpty && contentType.isNotNull)
          CupertinoButton(
              child: const Text('Ajouter'),
              onPressed: () {
                if (contentType.isNull || comments.isNullOrEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Veuillez remplir tous les champs')),
                  );
                  return;
                }
                LocalStorageHelper.addItem(
                  LocalStorageKeyEnum.babel,
                  Content(
                      name: contentName,
                      time: DateTime.now().millisecondsSinceEpoch,
                      type: contentType!,
                      comments: comments ?? '').toJson(),
                );
                context.read<LocalStorageBloc>().getItems();
                context.pop();
              }),
      ]));
}
