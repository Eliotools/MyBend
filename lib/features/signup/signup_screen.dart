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
  Widget buildPage(BuildContext context, DataState state) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                'Welcome on',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Gap(4),
              Text(
                'My Bend',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
          SignUpContent(
            onValidate: (username, password) =>
                cubit.signup(username, password),
          ),
          switch (state) {
            Loading() => const CircularProgressIndicator(),
            Error(message: final message) => Text(message),
            Loaded() => const Text('User created'),
            Initial() => const SizedBox.shrink(),
          },
        ],
      );
}

class SignUpContent extends StatefulWidget {
  const SignUpContent({super.key, required this.onValidate});

  final void Function(String, String) onValidate;

  @override
  State<SignUpContent> createState() => _SignUpContentState();
}

class _SignUpContentState extends State<SignUpContent> {
  String? username;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) => setState(() => username = value),
          decoration: const InputDecoration(hintText: 'Username'),
        ),
        const Gap(12),
        TextField(
          onChanged: (value) => setState(() => password = value),
          obscureText: true,
          decoration: const InputDecoration(hintText: 'Password'),
        ),
        const Gap(16),
        if (username.isNotNullOrEmpty && password.isNotNullOrEmpty)
          FilledButton(
            onPressed: () => widget.onValidate(username!, password!),
            child: const Text('Valider'),
          ),
      ],
    );
  }
}
