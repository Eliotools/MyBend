import 'package:flutter/material.dart';
import 'package:mybend/core/themes/app_colors.dart';
import 'package:mybend/core/themes/app_theme.dart';
import 'package:mybend/features/babel/babel_cubit.dart';
import 'package:mybend/features/babel/models/content.dart';
import 'package:mybend/shared/cubit_screen.dart';
import 'package:mybend/src/shared/data_state.dart';

class BabelScreen extends CubitScreen<BabelCubit, DataState> {
  const BabelScreen({super.key});

  @override
  void Function(BabelCubit cubit)? get onInit => (cubit) {
    print('==========================onInit=========================');
    cubit.load();
  };

  @override
  Widget buildPage(BuildContext context, DataState state) => Scaffold(
        appBar: AppBar(
          title: const Text('Babel'),
        ),
        body: switch (state) {
          //manage loding in CubitScreen with gloal state
          Initial() || Loading() => const Center(
              child: CircularProgressIndicator(),
            ),
          Error(message: final message) => Center(
              child: Text(
                message,
                style: AppTheme.textTheme.bodyMedium,
              ),
            ),
          Loaded<List<Content>>(data: final data) => data.isEmpty ? const Text('No content') : BabelContent(contents: data),
          _ => const SizedBox.shrink(),
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


class BabelContent extends StatefulWidget {
  const BabelContent({super.key, required this.contents});

  final List<Content> contents;

  @override
  State<BabelContent> createState() => _BabelContentState();
}

class _BabelContentState extends State<BabelContent> {
  ContentType selectedType = ContentType.book;

  @override
  Widget build(BuildContext context) {
    return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _TypeSelector(
                        label: 'Livre',
                        icon: Icons.book,
                        selected: selectedType == ContentType.book,
                        color: AppColors.containersColor['green']!,
                        onTap: () => setState(() => selectedType = ContentType.book),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _TypeSelector(
                        label: 'Film',
                        icon: Icons.movie,
                        selected: selectedType == ContentType.movie,
                        color: AppColors.containersColor['blue']!,
                        onTap: () => setState(() => selectedType = ContentType.movie),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (widget.contents.where((content) => content.type == selectedType).isEmpty)
                  Text(
                    'Aucun contenu',
                    style: AppTheme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  )
                else
                  ...widget.contents.where((content) => content.type == selectedType).map(
                    (content) => _ContentTile(content: content),
                  ),
              ],
            );
  }
}