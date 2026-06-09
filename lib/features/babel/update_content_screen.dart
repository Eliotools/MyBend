import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/core/extensions/context_extensions.dart';
import 'package:mybend/core/themes/app_theme.dart';
import 'package:mybend/features/babel/models/content.dart';
import 'package:mybend/features/babel/widgets/movie_poster_preview.dart';
import 'package:mybend/features/babel/widgets/star_rating.dart';

class UpdateContentScreen extends StatefulWidget {
  const UpdateContentScreen({
    super.key,
    required this.content,
    required this.callback,
  });

  final Content content;
  final void Function(Content content) callback;

  @override
  State<UpdateContentScreen> createState() => _UpdateContentScreenState();
}

class _UpdateContentScreenState extends State<UpdateContentScreen> {
  late ContentType selectedType;
  late ContentStatus selectedStatus;
  late int rating;
  String? imageUrl;
  late final TextEditingController _nameController;
  late final TextEditingController _commentsController;

  @override
  void initState() {
    super.initState();
    selectedType = widget.content.type;
    selectedStatus = widget.content.status;
    rating = widget.content.rating;
    imageUrl = widget.content.imageUrl;
    _nameController = TextEditingController(text: widget.content.name);
    _commentsController =
        TextEditingController(text: widget.content.comments ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _commentsController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir le nom')),
      );
      return;
    }

    if (rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez choisir une note')),
      );
      return;
    }

    widget.callback(
      Content(
        id: widget.content.id,
        name: _nameController.text.trim(),
        type: selectedType,
        time: widget.content.time,
        rating: rating,
        status: selectedStatus,
        comments: _commentsController.text.trim().isEmpty
            ? null
            : _commentsController.text.trim(),
        imageUrl:
            selectedType == ContentType.movie ? imageUrl : null,
      ),
    );

    if (mounted) context.pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update content')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: ContentType.values
                  .map(
                    (type) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedType == type
                                ? context.colorScheme.primary
                                : null,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.white,
                              width: selectedType == type ? 2 : 0,
                            ),
                          ),
                          child: InkWell(
                            onTap: () => setState(() {
                              selectedType = type;
                              if (type != ContentType.movie) imageUrl = null;
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
              onChanged: (value) {
                if (selectedType != ContentType.movie) {
                  setState(() => imageUrl = null);
                }
              },
              decoration: const InputDecoration(hintText: 'Nom'),
            ),
            if (selectedType == ContentType.movie) ...[
              const SizedBox(height: 16),
              MoviePosterPreview(
                movieName: _nameController.text,
                initialUrl: imageUrl,
                onPosterUrlChanged: (url) => imageUrl = url,
              ),
            ],
            const SizedBox(height: 16),
            Center(
              child: StarRating(
                rating: rating,
                onRatingChanged: (value) => setState(() => rating = value),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              //TODO: make this reusable (cf add content)
              children: ContentStatus.values
                  .map(
                    (status) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedStatus == status
                                ? context.colorScheme.primary
                                : null,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.white,
                              width: selectedStatus == status ? 2 : 0,
                            ),
                          ),
                          child: InkWell(
                            onTap: () =>
                                setState(() => selectedStatus = status),
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                status.label,
                                textAlign: TextAlign.center,
                                style: AppTheme.textTheme.bodyMedium,
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
              controller: _commentsController,
              decoration: const InputDecoration(hintText: 'Commentaires'),
              maxLines: 3,
            ),
            const Spacer(),
            CupertinoButton.filled(
              onPressed: _save,
              child: Text(
                'Modifier',
                style: AppTheme.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
