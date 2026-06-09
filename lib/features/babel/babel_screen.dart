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
  void Function(BabelCubit cubit)? get onInit => (cubit) => cubit.load();

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
          Loaded<List<Content>>(data: final data) => BabelContent(contents: data),
          _ => const SizedBox.shrink(),
        },
      );
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
                  children: ContentType.values.map((type) => Expanded(child: Container(
                    //TODO: update white customContainer
                    decoration: BoxDecoration(
                     color: selectedType == type ? AppColors.containersColor['green']! :null,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white, width: selectedType == type ? 2 : 0),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: InkWell(
                      onTap: () => setState(() => selectedType = type),
                      child: Column(
                          children: [Icon(type.icon), Text(type.name)],
                        ),
                      ),
                  ),),).toList(),
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
                    (content) => Container(
                      padding: const EdgeInsets.all(16),
                      child: Text(content.name),
                    ),
                  ),
              ],
            );
  }
}