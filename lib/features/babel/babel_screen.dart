import 'package:flutter/material.dart';
import 'package:mybend/core/themes/app_colors.dart';
import 'package:mybend/core/themes/app_theme.dart';
import 'package:mybend/features/babel/babel_cubit.dart';
import 'package:mybend/features/babel/models/content.dart';
import 'package:mybend/shared/cubit_screen.dart';

class BabelScreen extends CubitScreen<BabelCubit, BabelState> {
  const BabelScreen({super.key});

  @override
  void Function(BabelCubit cubit)? get onInit => (cubit) => cubit.load();

  @override
  Widget buildPage(BuildContext context, BabelState state) => Scaffold(
        appBar: AppBar(
          title: const Text('Babel'),
        ),
        body: switch (state.status) {
          //manage loding in CubitScreen with gloal state
          BabelStatus.initial || BabelStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
          BabelStatus.error => Center(
            //Same
              child: Text(
                'Impossible de charger Babel',
                style: AppTheme.textTheme.bodyMedium,
              ),
            ),
          BabelStatus.loaded => ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _TypeSelector(
                        label: 'Livre',
                        icon: Icons.book,
                        selected: state.selectedType == ContentType.book,
                        color: AppColors.containersColor['green']!,
                        onTap: () => cubit.selectType(ContentType.book),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _TypeSelector(
                        label: 'Film',
                        icon: Icons.movie,
                        selected: state.selectedType == ContentType.movie,
                        color: AppColors.containersColor['blue']!,
                        onTap: () => cubit.selectType(ContentType.movie),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (state.filteredContents.isEmpty)
                  Text(
                    'Aucun contenu',
                    style: AppTheme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  )
                else
                  ...state.filteredContents.map(
                    (content) => _ContentTile(content: content),
                  ),
              ],
            ),
        },
      );
}

class _TypeSelector extends StatelessWidget {
  const _TypeSelector({
    required this.label,
    required this.icon,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(selected ? 1 : 0.5),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Icon(icon),
              const SizedBox(height: 8),
              Text(label, style: AppTheme.textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContentTile extends StatelessWidget {
  const _ContentTile({required this.content});

  final Content content;

  @override
  Widget build(BuildContext context) {
    //use global container
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.containersColor['orange']!,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content.name,
            style: AppTheme.textTheme.titleMedium,
          ),
          if (content.comments?.isNotEmpty ?? false) ...[
            const SizedBox(height: 4),
            Text(
              content.comments!,
              style: AppTheme.textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
