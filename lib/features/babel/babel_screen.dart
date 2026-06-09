import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/core/extensions/context_extensions.dart';
import 'package:mybend/core/themes/app_theme.dart';
import 'package:mybend/features/babel/babel_cubit.dart';
import 'package:mybend/features/babel/models/content.dart';
import 'package:mybend/features/babel/widgets/star_rating.dart';
import 'package:mybend/shared/cubit_screen.dart';
import 'package:mybend/src/shared/data_state.dart';

class BabelScreen extends CubitScreen<BabelCubit, DataState> {
  const BabelScreen({super.key});

  @override
  void Function(BabelCubit cubit)? get onInit => (cubit) => cubit.load();

  @override
  String get name => 'Babel';

  @override
  Widget get floatingActionButton => Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () async {
            await context.push<bool>('/babel/add');
          },
          child: const Icon(Icons.add),
        ),
      );

  @override
  Widget buildPage(BuildContext context, DataState state) => switch (state) {
        Initial() || Loading() => const Center(
            child: CircularProgressIndicator(),
          ),
        Error(message: final message) => Center(
            child: Text(
              message,
              style: AppTheme.textTheme.bodyMedium,
            ),
          ),
        Loaded<List<Content>>(data: final data) => BabelContent(
            contents: data,
            onContentDoubleTap: (content) =>
                context.push<bool>('/babel/edit', extra: content),
          ),
        _ => const SizedBox.shrink(),
      };
}

class BabelContent extends StatefulWidget {
  const BabelContent({
    super.key,
    required this.contents,
    required this.onContentDoubleTap,
  });

  final List<Content> contents;
  final void Function(Content content) onContentDoubleTap;

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
          children: ContentType.values
              .map(
                (type) => Expanded(
                  child: Container(
                    //TODO: update white customContainer
                    decoration: BoxDecoration(
                      color: selectedType == type
                          ? context.colorScheme.primary
                          : null,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: Colors.white,
                          width: selectedType == type ? 2 : 0),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: InkWell(
                      onTap: () => setState(() => selectedType = type),
                      child: Column(
                        children: [Icon(type.icon), Text(type.name)],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 16),
        if (widget.contents
            .where((content) => content.type == selectedType)
            .isEmpty)
          Text(
            'Aucun contenu',
            style: AppTheme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          )
        else
          ...widget.contents
              .where((content) => content.type == selectedType)
              .map(
                (content) => GestureDetector(
                  onDoubleTap: () => widget.onContentDoubleTap(content),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary.withAlpha(51),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              content.name,
                              style: AppTheme.textTheme.titleMedium,
                            ),
                            if (content.rating > 0) ...[
                              StarRating(rating: content.rating, size: 20),
                            ],
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    context.colorScheme.primary.withAlpha(128),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                content.status.label,
                                style: AppTheme.textTheme.labelSmall,
                              ),
                            ),
                          ],
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
                  ),
                ),
              ),
      ],
    );
  }
}
