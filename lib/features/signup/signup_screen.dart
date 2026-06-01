import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mybend/features/signup/signup_cubit.dart';
import 'package:mybend/shared/cubit_screen.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class SignupScreen extends CubitScreen<SignupCubit, BaseState> {
  SignupScreen({super.key});

  @override
  void Function(SignupCubit cubit)? get onInit =>
      (cubit) => cubit.signup('test');

  @override
  Widget buildPage(BuildContext context, BaseState state) => Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SignupContent(onSubmit: (e) => cubit.signup(e)),
      ));
}

class SignupContent extends StatefulWidget {
  const SignupContent({super.key, required this.onSubmit});

  final Function(String) onSubmit;

  @override
  State<SignupContent> createState() => _SignupContentState();
}

class _SignupContentState extends State<SignupContent> {
  String? username;
  @override
  Widget build(BuildContext context) => Column(
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
            onChanged: (v) => setState(() => username = v),
            decoration: const InputDecoration(hintText: 'Notre Nom'),
          ),
          if (username.isNotNullOrEmpty)
            CupertinoButton(
                child: const Text('Valider'),
                onPressed: () {
                  widget.onSubmit(username!);
                }),
        ],
      );
}
