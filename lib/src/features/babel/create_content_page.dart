import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/src/enum/local_storage_key_enum.dart';
import 'package:mybend/src/features/bloc/local_storage_bloc.dart';
import 'package:mybend/src/helpers/local_storage_helper.dart';
import 'package:mybend/src/model/content.dart';
import 'package:mybend/src/shared/container.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class CreateContentPage extends StatefulWidget {
  const CreateContentPage({
    super.key,
    this.content,
  });

  static const name = "create-content";
  final Content? content;

  @override
  State<CreateContentPage> createState() => _CreateContentPageState();
}

class _CreateContentPageState extends State<CreateContentPage> {
  Content? content;

  @override
  void initState() {
    if (widget.content.isNull) return;
    content = Content.empty();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(widget.content.isNotNull
                  ? 'Modifier un contentu'
                  : 'Ajouter un contenu'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomContainer(
                    selected: content?.type == ContentType.book,
                    child: InkWell(
                      onTap: () => setState(() {
                        content?.type = ContentType.book;
                      }),
                      child: const Column(
                        children: [Icon(Icons.book), Text('Livre')],
                      ),
                    ),
                  ),
                  CustomContainer(
                    selected: content?.type == ContentType.movie,
                    child: InkWell(
                      onTap: () => setState(() {
                        content?.type = ContentType.movie;
                      }),
                      child: const Column(
                        children: [Icon(Icons.movie), Text('Film')],
                      ),
                    ),
                  )
                ],
              ),
              TextField(
                onChanged: (value) => setState(() => content?.name = value),
                decoration: const InputDecoration(hintText: 'Nom'),
              ),
              TextField(
                onChanged: (value) => setState(() => content?.comments = value),
                decoration: const InputDecoration(hintText: 'Commentaires'),
              ),
              CupertinoButton(
                  child: const Text('Ajouter'),
                  onPressed: () {
                    if (content.isNull || content!.name.isNullOrEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Veuillez remplir tous les champs')),
                      );
                      return;
                    }
                    LocalStorageHelper.addItem(
                      LocalStorageKeyEnum.babel,
                      content!,
                      setId: true,
                    );
                    context.read<LocalStorageBloc>().getItems();
                    context.pop();
                  }),
            ]),
      );
}
