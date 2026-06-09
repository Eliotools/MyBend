import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mybend/features/signup/signup_cubit.dart';
import 'package:mybend/shared/cubit_screen.dart';
import 'package:mybend/src/shared/data_state.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class SignupScreen extends CubitScreen<SignupCubit, DataState> {
  const SignupScreen({super.key});

  @override
  String get name => 'Signup';

  @override
  Widget buildPage(BuildContext context, DataState state) => Padding(
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
            SignUpContent(onValidate: (value) => cubit.signup(value)),
            switch (state) {
              Loading() => const CircularProgressIndicator(),
              Error(message: final message) => Text(message),
              Loaded() => const Center(child: Text('User created')),
              Initial() => const SizedBox.shrink(),
            },
          ],
        ),
      );
}

class SignUpContent extends StatefulWidget {
  const SignUpContent({super.key, required this.onValidate});

  final void Function(String) onValidate;

  @override
  State<SignUpContent> createState() => _SignUpContentState();
}

class _SignUpContentState extends State<SignUpContent> {
  String? username;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) => setState(() => username = value),
          decoration: const InputDecoration(hintText: 'Notre Nom'),
        ),
        if (username.isNotNullOrEmpty)
          CupertinoButton(
            onPressed: () => widget.onValidate(username!),
            child: const Text('Valider'),
          ),
      ],
    );
  }
}
