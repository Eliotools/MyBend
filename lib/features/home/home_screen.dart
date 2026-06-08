import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/core/themes/app_colors.dart';
import 'package:mybend/core/themes/app_theme.dart';
import 'package:mybend/features/home/home_cubit.dart';
import 'package:mybend/shared/cubit_screen.dart';

class HomeScreen extends CubitScreen<HomeCubit, HomeState> {
  const HomeScreen({super.key});

  @override
  void Function(HomeCubit cubit)? get onInit => (cubit) => cubit.load();

  @override
  Widget buildPage(BuildContext context, HomeState state) => Scaffold(
        appBar: AppBar(
          //use global appbar
          title: const Text('My Bend'),
        ),
        body: switch (state) {
          HomeState.initial || HomeState.loading => const Center(
              child: CircularProgressIndicator(),
            ),
          HomeState.loaded => Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Bonjour ${cubit.username}',
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
          HomeState.error => Center(
              child: Text(
                'Impossible de charger le profil',
                style: AppTheme.textTheme.bodyMedium,
              ),
            ),
        },
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
