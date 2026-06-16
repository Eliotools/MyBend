import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/features/babel/models/content.dart';
import 'package:mybend/features/babel/widgets/movie_poster_preview.dart';
import 'package:mybend/features/babel/widgets/star_rating.dart';
import 'package:mybend/shared/ui/custom_container.dart';
import 'package:mybend/shared/ui/modal_bottom_sheet.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class AddContentModal extends StatefulWidget {
  const AddContentModal({super.key, this.content} );

  final Content? content;

  @override
  State<AddContentModal> createState() => _AddContentModalState();
}

class _AddContentModalState extends State<AddContentModal> {
  Content content = Content.empty();
  final _nameController = TextEditingController();
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.content.isNotNull) {
    content = widget.content!;
    _commentController.text = content.comment ?? '';
    _nameController.text = content.name ?? '';
    }
  }

  @override
  Widget build(BuildContext context)=>  ModalBottomSheet(
        title: '${widget.content.isNotNull ? 'Update' : 'Add'} Babel',
        children: [
          Row(
            children: ContentType.values
                .map(
                  (type) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: CustomContainer(
                        selected: content.type == type,
                        small: true,
                        child: InkWell(
                          onTap: () => setState(() {
                            content = content.copyWith(type: type);
                            if (type != ContentType.movie) content.copyWith(imageUrl: null);
                          }),
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Icon(type.icon),
                                Text(type.name),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _nameController,
            onChanged: (value) => setState(() {
              content = content.copyWith(name: value);
              if (content.type != ContentType.movie) content = content.copyWith(imageUrl: null);
            }),
            decoration: const InputDecoration(hintText: 'Nom'),
          ),
          if (content.type == ContentType.movie) ...[
            const SizedBox(height: 16),
            MoviePosterPreview(
              movieName: content.name ?? '',
              onPosterUrlChanged: (url) => content = content.copyWith(imageUrl: url),
            ),
          ],
          const SizedBox(height: 16),
          Center(
            child: StarRatingButton(
              rating: content.rating,
              onRatingChanged: (value) => setState(() => content = content.copyWith(rating: value)),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: ContentStatus.values
                .map(
                  (status) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: CustomContainer(
                        selected: content.status == status,
                        small: true,
                        child: InkWell(
                          onTap: () => setState(() => content = content.copyWith(status: status)),
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              status.label,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _commentController,
            onChanged: (value) => setState(() => content = content.copyWith(comment: value) ),
            decoration: const InputDecoration(hintText: 'Commentaires'),
            maxLines: 3,
          ),
        const Gap(16),
          FilledButton(
            onPressed: () => context.pop(content),
            child: const Text('Ajouter'),
          ),
        ],
      );
   
}
