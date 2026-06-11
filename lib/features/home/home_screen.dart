import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/core/themes/app_theme.dart';
import 'package:mybend/features/home/home_cubit.dart';
import 'package:mybend/shared/cubit_screen.dart';
import 'package:mybend/shared/custom_container.dart';
import 'package:mybend/src/shared/data_state.dart';

class HomeScreen extends CubitScreen<HomeCubit, DataState> {
  const HomeScreen({super.key});

  @override
  String get name => 'Home';

  @override
  Widget buildPage(BuildContext context, DataState state) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Bonjour',
            style: AppTheme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const Gap(24),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1,
              children: [
                CustomContainer(
                  color: Colors.green,
                  child: InkWell(
                    onTap: () => context.push('/babel'),
                    child: const Center(child: Text('Babel')),
                  ),
                ),
                CustomContainer(
                  color: Colors.blue,
                  child: InkWell(
                    onTap: () => context.push('/alexandry'),
                    child: const Center(child: Text('Alexandry')),
                  ),
                ),
                CustomContainer(
                  color: Colors.purple,
                  child: InkWell(
                    onTap: () => context.push('/mybend'),
                    child: const Center(child: Text('My Bend')),
                  ),
                ),
                CustomContainer(
                  color: Colors.orange,
                  child: InkWell(
                    onTap: () => context.push('/sudoku'),
                    child: const Center(child: Text('Sudoky')),
                  ),
                ),
              ],
            ),
          ),
          const Gap(16),
          CupertinoButton(
            onPressed: cubit.clearStorage,
            child: const Text('Effacer les données'),
          ),
        ],
      );
}
