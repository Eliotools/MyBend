import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/core/extensions/context_extensions.dart';
import 'package:mybend/features/babel/add_content_modal.dart';
import 'package:mybend/features/babel/babel_cubit.dart';
import 'package:mybend/features/babel/models/content.dart';
import 'package:mybend/features/babel/widgets/star_rating.dart';
import 'package:mybend/shared/cubit_screen.dart';
import 'package:mybend/shared/ui/custom_container.dart';
import 'package:mybend/src/shared/data_state.dart';

class BabelScreen extends CubitScreen<BabelCubit, DataState> {
  const BabelScreen({super.key});

  @override
  void Function(BabelCubit cubit)? get onInit => (cubit) => cubit.load();

  @override
  String get name => 'Babel';

  @override
  Widget Function(BuildContext context, DataState state)?
      get floatingActionButton => (context, state) => Builder(
            builder: (context) => FloatingActionButton(
              onPressed: () => showModalBottomSheet<Content>(
                isScrollControlled: true,
                context: context,
                builder: (context) => const AddContentModal(),
              ).then((value) => value != null ? cubit.addContent(value) : null),
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
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        Loaded<List<Content>>(data: final data) => BabelContent(
            contents: data,
          ),
        _ => const SizedBox.shrink(),
      };
}

//This could be in a separated file
class BabelContent extends StatefulWidget {
  const BabelContent({
    super.key,
    required this.contents,
  });

  final List<Content> contents;

  @override
  State<BabelContent> createState() => _BabelContentState();
}

class _BabelContentState extends State<BabelContent> {
  ContentType selectedType = ContentType.book;
              
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: ContentType.values
              .map(
                (type) => Expanded(
                  child: CustomContainer(
                    selected: selectedType == type,
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
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          )
        else
          ...widget.contents
              .where((content) => content.type == selectedType)
              .map(
                (content) => GestureDetector(
                  onDoubleTap: () => showModalBottomSheet<Content>(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => AddContentModal(content: content),
                  ).then((value) => value != null
                      ? context.read<BabelCubit>().updateContent(value)
                      : null),
                  child: CustomContainer(
                    color: context.colorScheme.primary.withAlpha(51),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (content.type == ContentType.movie &&
                            content.imageUrl != null) ...[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              content.imageUrl!,
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const SizedBox.shrink(),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              content.name ?? 'No found',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Chip(
                              label: Text(content.status.label),
                              visualDensity: VisualDensity.compact,
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                        if (content.rating > 0) ...[
                          Row(
                            children: [
                              const Spacer(),
                              StarRating(rating: content.rating, size: 20),
                            ],
                          )
                        ],
                        if (content.comment?.isNotEmpty ?? false) ...[
                          const SizedBox(height: 4),
                          Text(
                            content.comment!,
                            style: Theme.of(context).textTheme.bodySmall,
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
