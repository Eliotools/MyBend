import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mybend/src/features/home/home_cubit.dart';
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
        padding: EdgeInsets.all(8.0),
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
                const Gap(4),
                Text(
                  'My Bend',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            TextField(
              onChanged: (v) => setState(() => name = v),
              decoration: InputDecoration(hintText: 'Notre Nom'),
            ),
            if (name.isNotNullOrEmpty)
              CupertinoButton(
                  child: Text('Valider'),
                  onPressed: () => context.read<HomeCubit>().setName(name!)),
          ],
        ),
      );
}
