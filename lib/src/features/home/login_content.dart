import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mybend/src/enum/local_storage_key_enum.dart';
import 'package:mybend/src/features/bloc/local_storage_bloc.dart';
import 'package:mybend/src/helpers/local_storage_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});


  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  String? name;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Column(
              children: [
                Text(
                  'Welcome on',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Gap(4),
                Text(
                  'My Bend',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            TextField(
              onChanged: (v) => setState(() => name = v),
              decoration: const InputDecoration(hintText: 'Notre Nom'),
            ),
            if (name.isNotNullOrEmpty)
              CupertinoButton(
                  child: const Text('Valider'),
                  onPressed: () {
                    LocalStorageHelper.setItem(LocalStorageKeyEnum.name, name!);
                    context.read<LocalStorageBloc>().getItems();
                  }),
          ],
        ),
      );
}
