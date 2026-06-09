import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/core/themes/app_colors.dart';
import 'package:mybend/core/themes/app_theme.dart';
import 'package:mybend/features/home/home_cubit.dart';
import 'package:mybend/shared/cubit_screen.dart';
import 'package:mybend/src/shared/data_state.dart';

class HomeScreen extends CubitScreen<HomeCubit, DataState> {
  const HomeScreen({super.key});

  @override
  void Function(HomeCubit cubit)? get onInit => (cubit) => cubit.load();

  @override
  Widget buildPage(BuildContext context, DataState state) => Scaffold(
        appBar: AppBar(
          //use global appbar
          title: const Text('My Bend'),
        ),
        body: switch (state) {
          Initial() || Loading() => const Center(
              child: CircularProgressIndicator(),
            ),
          Loaded<String?>(data: final data) => Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Bonjour $data',
                    style: AppTheme.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const Gap(24),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1,
                      children: [
                        _HomePlaceholderTile(
                          //use global container
                          label: 'Babel',
                          color: AppColors.containersColor['green']!,
                          onTap: () => context.push('/babel'),
                        ),
                        _HomePlaceholderTile(
                          label: 'Alexandry',
                          color: AppColors.containersColor['blue']!,
                          onTap: () => context.push('/alexandry'),
                        ),
                        _HomePlaceholderTile(
                          label: 'MyBend',
                          color: AppColors.containersColor['yellow']!,
                          onTap: () => context.push('/mybend'),
                        ),
                        _HomePlaceholderTile(
                          label: 'Sudoku',
                          color: AppColors.containersColor['orange']!,
                          onTap: () => context.push('/sudoku'),
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
              ),
            ),
          Error(message: final message) => Center(
              child: Text(
                message,
                style: AppTheme.textTheme.bodyMedium,
              ),
            ),
            _ => const SizedBox.shrink(),
        }
      );
}

class _HomePlaceholderTile extends StatelessWidget {
  //remove this usless thing
  const _HomePlaceholderTile({
    required this.label,
    required this.color,
    this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: Text(
            label,
            style: AppTheme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
