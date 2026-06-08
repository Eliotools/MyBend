import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mybend/features/signup/signup_cubit.dart';
import 'package:mybend/shared/cubit_screen.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class SignupScreen extends CubitScreen<SignupCubit, SignupState> {
  const SignupScreen({super.key});

  @override
  Widget buildPage(BuildContext context, SignupState state) => Scaffold(
        body: Padding(
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
                onChanged: cubit.updateUsername,
                decoration: const InputDecoration(hintText: 'Notre Nom'),
              ),
              if (state.status == SignupStatus.loading)
                const CircularProgressIndicator(),
              if (state.status == SignupStatus.error)
                const Text('Une erreur est survenue'),
              if (state.username.isNotNullOrEmpty &&
                  state.status != SignupStatus.loading)
                CupertinoButton(
                  onPressed: cubit.signup,
                  child: const Text('Valider'),
                ),
            ],
          ),
        ),
      );
}
